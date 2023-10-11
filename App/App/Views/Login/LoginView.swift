//
//  RegisterView.swift
//  App
//
//  Created by Thanh Hien on 19/09/2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    var body: some View {
        NavigationView {
            VStack(alignment: .leading,spacing: 0) {
                Spacer().frame(height: 50)
                Group {
                    Text("Lets Sign you in")
                        .foregroundColor(Color("4A3AFF"))
                        .font(.system(size: 37))
                        .bold()
                    Text("Welcome Back,")
                        .font(.system(size: 30))
                        .padding(.top, 10)
                        .frame(width: 300)
                    Text("You're been missed")
                        .font(.system(size: 30))
                        .padding(.top, 10)
                        .frame(width: 300)
                }
                .frame(maxWidth: .infinity)
                Spacer().frame(height: 50)
                Group {
                    TLTextField(title: "Email", color: Color("4A3AFF"), text: $viewModel.email)
                    
                    TLTextField(title: "Password", color: Color("4A3AFF"), text: $viewModel.email)
                    NavigationLink("Forgot Password ?", destination: RegisterView())
                        .foregroundColor(.black)
                        .padding([.top,.trailing], 12)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Spacer().frame(height: 30)
                    TLButton(title: "Login", background:  Color("4A3AFF"), action: {
                        
                    })
                    Spacer().frame(height: 30)
                    HStack {
                        VStack {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.gray)
                        }
                        Text("or")
                            .bold()
                        VStack {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                .padding([.leading, .trailing], 22)
                Spacer().frame(height: 25)
                Group {
                    HStack(spacing: 15) {
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
                        Button(action: {
                            // ac
                        }) {
                            Image("apple")
                                .resizable()
                                .frame(width: 45, height: 48)
                                .clipShape(Circle())
                        }
                        
                    }
                    
                    HStack {
                        Text("Don’t have an account ?")
                            .foregroundColor(.gray)
                        NavigationLink("Register Now", destination: RegisterView())
                            .foregroundColor(.black)
                            .bold()
                    }
                    .font(.system(size: 15))
                    .padding(.top, 25)
                }
                .frame(maxWidth: .infinity)
                
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
