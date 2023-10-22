//
//  ProfileView.swift
//  App
//
//  Created by Thanh Hien on 15/10/2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var path : NavigationPath
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 15)
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("left")
                        .padding(.leading, 15)
                }
                Text("Your Account")
                    .font(.system(size: 22))
                    .foregroundColor(Color("002482"))
                    .padding(.leading, 15)
                Spacer()
            }
            Spacer().frame(height: 80)
                HStack {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("002482"))
                            .frame(width: 20, height: 20)
                        Text("Name")
                            .font(.system(size: 16))
                            .foregroundColor(Color("002482"))
                            .padding(.leading, 10)
                        Spacer()
                        Text(viewModel.profile?.name ?? "")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                        Image("rightlight")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .padding(.trailing, 20)
                    }
                }
                .padding(.leading, 30)
            //gender
            HStack {
                Button(action: {
                    
                }) {
                    Image("gender")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                    Text("Gender")
                        .font(.system(size: 16))
                        .foregroundColor(Color("002482"))
                        .padding(.leading, 10)
                    Spacer()
                    Text(viewModel.profile?.phone ?? "")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                    Image("rightlight")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .padding(.trailing, 20)
                }
            }
            .padding([.top, .leading], 30)
            // email
            HStack {
                Button(action: {
                    
                }) {
                    Image("email")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                    Text("Email")
                        .font(.system(size: 16))
                        .foregroundColor(Color("002482"))
                        .padding(.leading, 10)
                    Spacer()
                    Text(viewModel.profile?.email ?? "")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                    Image("rightlight")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .padding(.trailing, 20)
                }
            }
            .padding([.top, .leading], 30)
//             phone
            HStack {
                Button(action: {

                }) {
                    Image("smartphone")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                    Text("Phone")
                        .font(.system(size: 16))
                        .foregroundColor(Color("002482"))
                        .padding(.leading, 10)
                    Spacer()
                    Text(viewModel.profile?.phone ?? "")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                    Image("rightlight")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 22, height: 22)
                        .padding(.trailing, 20)
                }
            }
            .padding([.top, .leading], 30)
            //password
              HStack {
                  Button(action: {

                  }) {
                      Image("changePassword")
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 22, height: 22)
                      Text("Change password")
                          .font(.system(size: 16))
                          .foregroundColor(Color("002482"))
                          .padding(.leading, 10)
                      Spacer()
                      Text(viewModel.profile?.phone ?? "")
                          .font(.system(size: 15))
                          .foregroundColor(.gray)
                          .padding(.trailing, 10)
                      Image("rightlight")
                          .resizable()
                          .aspectRatio(contentMode: .fit)
                          .frame(width: 22, height: 22)
                          .padding(.trailing, 20)
                  }
              }
              .padding([.top, .leading], 30)
           Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct PhoneView: View {
//    @ObservedObject var viewModel = ProfileViewModel()
//    var body: some View {
//            HStack {
//                Button(action: {
//
//                }) {
//                    Image("smartphone")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 22, height: 22)
//                    Text("Phone")
//                        .font(.system(size: 16))
//                        .foregroundColor(Color("002482"))
//                        .padding(.leading, 10)
//                    Spacer()
//                    Text(viewModel.profile?.phone ?? "")
//                        .font(.system(size: 15))
//                        .foregroundColor(.gray)
//                        .padding(.trailing, 10)
//                    Image("rightlight")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 22, height: 22)
//                        .padding(.trailing, 20)
//                }
//            }
//            .padding(.leading, 30)
//    }
//}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        return ProfileView(path: .constant(NavigationPath()))
    }
}
