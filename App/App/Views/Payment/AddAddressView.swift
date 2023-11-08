//
//  AddAddressView.swift
//  App
//
//  Created by Thanh Hien on 21/10/2023.
//

import SwiftUI

struct AddAddressView: View {
    @ObservedObject var viewModel = AddressViewModel()
    @State var name: String = ""
    @State var text: String = ""
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(alignment: .leading)  {
            Spacer().frame(height: 20)
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
                Text("Địa chỉ mới")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .padding(.leading, 15)
                Spacer()
            }
            Spacer().frame(height: 40)
            CustomTextFile(title: "Họ và tên", text: viewModel.name)
            CustomTextFile(title: "Số điện thoại", text: viewModel.phone)
            CustomTextFile(title: "Địa chỉ đường phố", text: viewModel.street)
            CustomTextFile(title: "Tỉnh/Thành phố", text: viewModel.city)
            CustomTextFile(title: "Quận/Huyện", text: viewModel.district)
            HStack(spacing: 20) {
                Button(action: {
                    // action
                }) {
                    Text("Delete")
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                        .fontWeight(.medium)
                        .padding(10)
                        .frame(width: 160, height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8).stroke(.red))
                }
                Button(action: {
                    // action
                }) {
                    Text("Add Address")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .padding(10)
                        .frame(width: 160, height: 40)
                }
                .background(Color("002482"))
                .cornerRadius(8)
            }
            
            .padding(.horizontal, 35)
            .padding(.top, 30)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}
struct AddAddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddAddressView(path: .constant(NavigationPath()))
    }
}
