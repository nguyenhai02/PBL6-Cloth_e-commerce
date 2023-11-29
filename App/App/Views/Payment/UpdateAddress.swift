//
//  UpdateAddressView.swift
//  App
//
//  Created by Thanh Hien on 11/11/2023.
//

import SwiftUI

struct UpdateAddressView: View, Hashable {
    static func == (lhs: UpdateAddressView, rhs: UpdateAddressView) -> Bool {
        return true
    }
    func hash(into hasher: inout Hasher) {}
    @ObservedObject var viewModel: AddressViewModel
    @Binding var path: NavigationPath
    @State var itemAddess: Address
    var indexEdit: Int = 0
    @State var showingError: Bool = false
    
    var body: some View {
        ZStack {
            Color("F9F9F9")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading)  {
                HStack {
                    Button(action: {
                        path.removeLast()
                    }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 18, height: 18)
                            .padding(.leading, 25)
                    }
                    Text("Sửa địa chỉ")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .padding(.leading, 15)
                    Spacer()
                }
                Spacer().frame(height: 18)
                Divider().background(Color.gray.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 0).stroke(Color.gray.opacity(0.1), lineWidth: 1)
                    ).shadow(radius: 2)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Họ và tên")
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.6))
                            .padding(.leading, 15)
                            .padding(.top, 5)
                    }
                    TextFielCustom(title: "Họ và tên", text: $itemAddess.name)
                    Text("Số điện thoại")
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.6))
                        .padding(.leading, 15)
                        .padding(.top, 5)
                    TextFielCustom(title: "Số điện thoai", text: $itemAddess.phone )
                    Text("Địa chỉ")
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.6))
                        .padding(.leading, 15)
                        .padding(.top, 5)
                    ZStack(alignment: .trailing) {
                        HStack {TextFielCustom(title: "Địa chỉ", text: Binding<String>(get: {
                            if(itemAddess.ward.isEmpty && itemAddess.district.isEmpty && itemAddess.ward.isEmpty){
                                return ""
                            }else{
                                return "\(itemAddess.ward), \(itemAddess.district), \(itemAddess.city)"
                            }
                        }, set: {newValue in
                            if(newValue.isEmpty){
                                itemAddess.ward = ""
                                itemAddess.district = ""
                                itemAddess.city = ""
                            }
                        }))
                               
                            Spacer()
                            Button(action: {
                                path.append(ProvinceView(path: $path, viewModel: viewModel))
                            }) {
                                Image("rightlight")
                            }
                            .padding(.trailing, 15)
                        }
                    }
                    .background(.white)
                    Text("Tên đường, Toà nhà, Số nhà")
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.6))
                        .padding(.leading, 15)
                        .padding(.top, 5)
                    TextFielCustom(title: "Tên đường, Toà nhà, Số nhà", text: $itemAddess.street)
                    TLButton(title: "Hoàn thành", background: Color("FF3300").opacity(0.8)) {
                        if !viewModel.errorMessage.isEmpty {
                            showingError = true
                        }
                        viewModel.editAddress(indexEdit: indexEdit, address: itemAddess) {
                            path.removeLast()
                        }
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 10)
                    .alert(isPresented: $showingError) {
                        Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
                    }
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(for: ProvinceView.self)  { _ in
            ProvinceView(path: $path, viewModel: viewModel)
        }
        .onReceive(viewModel.$city) { city in
            if(!city.isEmpty){
                itemAddess.city = city
            }
        }
        .onReceive(viewModel.$district) { district in
            if(!district.isEmpty){
                itemAddess.district = district
            }
        }
        .onReceive(viewModel.$ward) { ward in
            if !ward.isEmpty{
                itemAddess.ward = ward
            }
        }
    }
}

struct UpdateAddressView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateAddressView(viewModel: AddressViewModel(), path: .constant(NavigationPath()), itemAddess: Address(name: "Thanh Hien", phone: "056724353", street: "Khanh toan", city: "da nang", ward: "hai chau", district: "hoa cuong"))
    }
}
