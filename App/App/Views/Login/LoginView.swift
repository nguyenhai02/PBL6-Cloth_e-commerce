//
//  RegisterView.swift
//  App
//
//  Created by Thanh Hien on 19/09/2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @Binding var path : NavigationPath
    @State var showingForgotPassword = false
    @State var showingRegister = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            Spacer().frame(height: 45)
            Group {
                Image("logo1")
                    .resizable()
                    .frame(width: 72, height: 72)
                Text("Welcome back to E-Com!")
                    .padding(.top, 30)
                    .font(.system(size: 18))
                    .bold()
                Text("Sign in to continue")
                    .font(.system(size: 18))
                    .foregroundColor(Color("848484"))
                    .padding(.top, 2)
                Text("\(viewModel.errorMessage)")
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .padding(.top, 20)
            }
            .frame(maxWidth: .infinity)
            
            Group {
                Spacer().frame(height: 30)
                TLTextField(title: "Email", color: Color("002482"), imageURL: "message", text: $viewModel.email, onTextChange: { newText in
                    viewModel.onValidateEmail(email:newText)
                })
                if(!viewModel.emailError.isEmpty){
                    Text(viewModel.emailError)
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                        .padding(.top, 3)
                }
                
                TLSecureField(title: "Password", color: Color("002482"),imageURL: "password", text: $viewModel.password)
                Button(action: {
                    self.showingForgotPassword = true
                }) {
                    Text("Forgot Password ?")
                        .foregroundColor(Color("002482"))
                        .font(.system(size: 12))
                        .bold()
                        .padding([.top,.trailing], 10)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                Spacer().frame(height: 20)
                TLButton(title: "Login", background:  Color("002482"), action: {
                    viewModel.login()
                })
                Spacer().frame(height: 20)
                HStack {
                    VStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray)
                    }
                    Text("or")
                        .bold()
                        .foregroundColor(Color("848484"))
                    VStack {
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray)
                    }
                }
            }
            .padding([.leading, .trailing], 30)
            Spacer().frame(height: 20)
            Group {
                Text("Login using")
                    .font(.system(size: 15))
                    .foregroundColor(Color("323232"))
                Spacer().frame(height: 20)
                HStack(spacing: 15) {
                    Button(action: {
                        // ac
                    }) {
                        Image("apple")
                            .resizable()
                            .frame(width: 45, height: 48)
                            .clipShape(Circle())
                    }
                    Button(action: {
                        // ac
                    }) {
                        Image("google")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                    Button(action: {
                        // ac
                    }) {
                        Image("facebook")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                }
                HStack {
                    Text("Don’t have an account ?")
                        .foregroundColor(.gray)
                    Button(action: {
                        self.showingRegister = true
                    }) {
                        Text("Register Now")
                            .bold()
                            .foregroundColor(Color("002482"))
                    }
                }
                .font(.system(size: 15))
                .padding(.top, 15)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .navigationDestination(isPresented: $viewModel.isLoggIned){
            TagBarView(path: $path)
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $showingForgotPassword, destination: {
            ForgotPasswordView(path: $path)
        })
        .navigationDestination(isPresented: $showingRegister, destination: {
            RegisterView(path: $path)
        })
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(path: Binding(get: {
            NavigationPath()
        }, set: { _, _ in
        }))
    }
}
