//
//  NewPasswordView.swift
//  App
//
//  Created by Thanh Hien on 13/10/2023.
//

import SwiftUI

struct NewPasswordView: View {
    @ObservedObject var viewModel = NewPasswordViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
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
                    Text("Set new password for your account.")
                        .font(.system(size: 14))
                        .foregroundColor(Color("676767"))
                        .multilineTextAlignment(.center)
                        .padding(.top, 9)
                }
                .frame(maxWidth: .infinity)
                Group {
                    TLTextField(title: "Password", color: Color("002482"), imageURL: "password", text: $viewModel.password)
                        .padding(.top, 30)
                    TLTextField(title: "Confirm Password", color: Color("002482"), imageURL: "password", text: $viewModel.confirmPassword)
                    TLButton(title: "Send Verification", background: Color("002482"), action: {
//                        viewModel.forgotPassword()
                    })
                    .padding(.top, 42)
                }
                .padding([.leading, .trailing], 30)
                Spacer()
            }
        .navigationBarBackButtonHidden()
//        .navigationBarItems(leading: Button(action: {
//            self.presentationMode.wrappedValue.dismiss()
//        }) {
//            HStack {
//                Image(systemName: "arrow.left")
//                    .foregroundColor(.gray)
//            }
//        })
    }
}

struct NewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordView()
    }
}
