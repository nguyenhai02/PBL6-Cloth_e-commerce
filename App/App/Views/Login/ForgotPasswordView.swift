//
//  ForgotPassword.swift
//  App
//
//  Created by Thanh Hien on 13/10/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var viewModel = ForgotPasswordViewModel()
    @Binding var path: NavigationPath
    var body: some View {
        ZStack(alignment: .trailing){
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 100)
                Group {
                    Image("logo1")
                        .resizable()
                        .frame(width: 72, height: 72)
                    Text("Forgot Password")
                        .font(.system(size: 18))
                        .bold()
                        .padding(.top, 26)
                    Text("We will send you a message to set or reset your new password")
                        .font(.system(size: 14))
                        .foregroundColor(Color("676767"))
                        .multilineTextAlignment(.center)
                        .padding(.top, 9)
                }
                .frame(maxWidth: .infinity)
                Group {
                    TLTextField(title: "Email", color: Color("002482"), imageURL: "person", text: $viewModel.email)
                        .padding(.top, 30)
                    TLButton(title: "Send Verification", background: Color("002482"), action: {
                        //                        viewModel.forgotPassword()
                    })
                    .padding(.top, 42)
                }
                .padding([.leading, .trailing], 30)
                Spacer()
            }
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: Button(action: {
                path.removeLast()
            }) {
                HStack {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.gray)
                }
            })
        }
    }
}

struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(path: Binding<NavigationPath>(get: {
            NavigationPath()
        }, set: { _, _ in
        }))
    }
}
