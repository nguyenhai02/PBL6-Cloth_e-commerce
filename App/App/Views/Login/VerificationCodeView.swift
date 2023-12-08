//
//  VerificationCodeView.swift
//  App
//
//  Created by Thanh Hien on 13/10/2023.
//

import SwiftUI

struct VerificationCodeView: View {
    @ObservedObject var viewModel = VerificationCodeViewModel()
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var isFocused: Bool
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
                    Text("Enter Verification Code")
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
                    Spacer().frame(height: 40)
                    TextField("Enter OTP",text: $viewModel.otp)
                        .padding(.leading, 16)
                        .frame(height: 48)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isFocused ? Color("002482") : Color("E1E2E7"), lineWidth: 1)
                        )
                        .focused($isFocused) // Sử dụng .focused với FocusState
                        .padding(.top, 2)
                    TLButton(title: "Send Verification", background: Color("002482"), action: {
                        viewModel.VerificationCode()
                    })
                    .padding(.top, 42)
                }
                .padding([.leading, .trailing], 30)
                Spacer()
            }
            .navigationBarBackButtonHidden()
        }
    }
}

struct VerificationCodeView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationCodeView()
    }
}
