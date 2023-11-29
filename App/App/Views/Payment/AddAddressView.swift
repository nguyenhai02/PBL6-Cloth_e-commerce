//
//  AddAddressView.swift
//  App
//
//  Created by Thanh Hien on 21/10/2023.
//

import SwiftUI

struct AddAddressView: View, Hashable {
    static func == (lhs: AddAddressView, rhs: AddAddressView) -> Bool {
        return true
    }
    func hash(into hasher: inout Hasher) {}
    @ObservedObject var viewModel = AddressViewModel()
    @State var name: String = ""
    @State var text: String = ""
    @Binding var path: NavigationPath
    @State var showingAlert = false
    
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
                    Text("Thêm địa chỉ")
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
                        Text("Liên hệ")
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.6))
                            .padding(.leading, 15)
                            .padding(.top, 5)
                    }
                    TextFielCustom(title: "Họ và tên", text: $viewModel.name)
                    TextFielCustom(title: "Số điện thoai", text: $viewModel.phone)
                    Text("Địa chỉ")
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.6))
                        .padding(.leading, 15)
                        .padding(.top, 5)
                    ZStack(alignment: .trailing) {
                        HStack {
                        if viewModel.city == "" {
                            TextFielCustom(title: "Tỉnh/Thành phố,Quận/Huyện,Phường/Xã ", text: $viewModel.city)
                        } else {
                            Text("\(viewModel.ward), \(viewModel.district), \(viewModel.city)" )
                                .font(.system(size: 15))
                                .foregroundColor(.black)
                                .padding()
                        }
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
                    TextFielCustom(title: "Tên đường, Toà nhà, Số nhà", text: $viewModel.street)
                    TLButton(title: "Hoàn thành", background: Color("FF3300").opacity(0.8)) {
                        viewModel.saveAddress(Address(name: viewModel.name, phone: viewModel.phone, street: viewModel.street, city: viewModel.city, ward: viewModel.ward, district: viewModel.district)) {
                            path.removeLast()
                        }
                        if !viewModel.errorMessage.isEmpty {
                            showingAlert = true
                        }
                    print("ADD")
                        print(Address(name: viewModel.name, phone: viewModel.phone, street: viewModel.street, city: viewModel.city, ward: viewModel.ward, district: viewModel.district))
                    }
                    .padding(.top, 40)
                    .padding(.horizontal, 10)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
                    }
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(for: ProvinceView.self)  { _ in
            ProvinceView(path: $path, viewModel: viewModel)
        }
        .onAppear {
            viewModel.getAddressFromURL() {_ in}
        }
    }
}
struct TextFielCustom: View {
    let title: String
    @Binding var text: String
    var body: some View {
        HStack() {
            TextField(title, text: $text)
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                Spacer()
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 14)
                    }
                }
            }
            .padding()
            .background(.white)
    }
}

    
struct AddAddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddAddressView(viewModel: AddressViewModel(), path: .constant(NavigationPath()))
    }
}
