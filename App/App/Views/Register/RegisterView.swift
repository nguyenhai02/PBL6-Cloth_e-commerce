//
//  RegisterView.swift
//  App
//
//  Created by Thanh Hien on 19/09/2023.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel = RegisterViewModel()
    @Binding var path : NavigationPath
    
    var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 40)
                Group {
                    Image("logo1")
                        .resizable()
                        .frame(width: 72, height: 72)
                    Text("Welcome to E-Com!")
                        .font(.system(size: 18))
                        .padding(.top, 20)
                        .bold()
                    Text("Let’s make your account.")
                        .font(.system(size: 16))
                        .foregroundColor(Color("848484"))
                        .padding(.top, 2)
                    if !viewModel.errorMessage.isEmpty {
                        Text("\(viewModel.errorMessage)")
                            .foregroundColor(.red)
                            .font(.system(size: 12))
                            .padding(.top, 15)
                    }
                }
                .frame(maxWidth: .infinity)
                Spacer().frame(height: 20)
                Group {
                    TLTextField(title: "Name", color: Color("002482"), imageURL: "person", text: $viewModel.name)
                    TLTextField(title: "Email", color: Color("002482"), imageURL: "message", text: $viewModel.email)
                    TLSecureField(title: "Password", color: Color("002482"), imageURL: "password", text: $viewModel.password)
                    TLTextField(title: "Address", color: Color("002482"), imageURL: "address",  text: $viewModel.address)
                    TLTextField(title: "Phone", color: Color("002482"), imageURL: "phone", text: $viewModel.phone)
                    Spacer().frame(height: 35)
                    TLButton(title: "Sign up", background: Color("002482"), action: {
                        viewModel.Register(completed: { isRegister in
                            if isRegister {
                                path.append("TagBarView")
                            } else {
                                path.append("LoginView")
                            }
                        })
                    })
                }
                .padding([.leading, .trailing], 30)
                HStack {
                    Text("Already  have an account ?")
                        .foregroundColor(.gray)
                    Button(action: {
                        path.append("LoginView")
                    }) {
                        Text("Login")
                            .bold()
                            .foregroundColor(Color("002482"))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
                Spacer()
            }
        .navigationBarBackButtonHidden()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(path: .constant(NavigationPath()))
    }
}
