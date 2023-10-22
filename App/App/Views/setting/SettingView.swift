//
//  SettingView.swift
//  App
//
//  Created by Thanh Hien on 21/10/2023.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @State private var logout = false
    @State var showMyOrder = false
    @State var showAddress = false
    @State var showWishlist = false
    @State var showPayment = false
    
    @Binding var path : NavigationPath
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 40)
            HStack {
                Image("product")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 57, height: 57)
                VStack(alignment: .leading, spacing: 0) {
                    Text(viewModel.profile?.name ?? "")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    Text(viewModel.profile?.email ?? "")
                        .font(.system(size: 16))
                        .foregroundColor(Color.gray)
                        .padding(.top, 3)
                }
                .padding(.leading, 10)
            }
            .padding(.leading, 20)
            Spacer().frame(height: 20)
            ForEach(viewModel.array, id: \.id) { item in
                Button(action: {
                    switch(item.id){
                    case 1:
                        showMyOrder.toggle()
                        break
                    case 2:
                        showAddress.toggle()
                        break
                    case 3:
                        showPayment.toggle()
                    default:
                        return
                    }
                }) {
                    HStack {
                        Image(item.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                        Text(item.tiltle)
                            .font(.system(size: 14))
//                            .fontWeight(.medium)
                            .foregroundColor(.black)
                        Spacer()
                        Image("right")
                            .resizable()
                            .frame(width: 8, height: 14)
                            .padding(.trailing, 30)
                    }
                   
                }
                .padding(.top, 30)
                .padding(.leading, 28)
            }
                Button(action: {
                    viewModel.logOut()
                    logout = true
                    path.popToRoot()
                }) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20)
                        Text("Logout")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                }
                .padding(.top, 30)
                .padding(.leading, 30)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $logout) {
            LoginView(path: $path)
        }
        .navigationDestination(isPresented: $showAddress) {
            ChooseAddressView(path: $path)
        }
        .navigationDestination(isPresented: $showWishlist) {
            FavoriteView(path: $path)
        }
        .navigationDestination(isPresented: $showPayment) {
            ChoosePaymentView(path: $path)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        let  viewModel = ProfileViewModel()
        viewModel.profile = Profile(id: 1, name: "Hien", email: "Hien@gmail.com", address: "DN", phone: "0582435722", role: "user", enabled: false, username: "Hien@gmail.com")
        return SettingView(viewModel: viewModel, path: .constant(NavigationPath()))
    }
}

extension NavigationPath{
    mutating func popToRoot() {
        self = NavigationPath()
    }
}
