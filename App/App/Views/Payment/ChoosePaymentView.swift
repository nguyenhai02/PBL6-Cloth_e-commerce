//
//  ChoosePaymentView.swift
//  App
//
//  Created by Thanh Hien on 19/10/2023.
//

import SwiftUI

struct ChoosePaymentView: View {
    @Binding var path: NavigationPath
    @State private var isMoneyButtonSelected = false
    @State private var isVnpayButtonSelected = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 30)
            HStack(spacing: 0) {
                Button(action: {
                    path.removeLast()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 18, height: 18)
                        .padding(.leading, 25)
                }
                Text("Chọn phương thức thanh toán ")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .padding(.leading, 15)
                Spacer()
            }
            Spacer().frame(height: 45)
//            Divider().background(Color("EBF0FF"))
            Button(action: {
                isMoneyButtonSelected = true
                isVnpayButtonSelected = false
                path.append("TransferMoneyView")
//                path.removeLast(2)
            }) {
                HStack {
                    Image("vnpay")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20)
                    Text("Vnpay")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .fontWeight(.medium)
                        .padding(.leading, 10)
                    Spacer()
                }
                .padding(.vertical, 18)
                .padding(.leading, 38)
                
                .frame(width: UIScreen.main.bounds.width)
                .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color("EBF0FF")))
                .background(isMoneyButtonSelected ? Color("EBF0FF") : Color.clear)
              
            }
//            Divider().background(Color("EBF0FF"))
            Button(action: {
                isMoneyButtonSelected = false
                isVnpayButtonSelected = true
            }) {
                HStack {
                    Image("money")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 28, height: 28)
                    Text("Thanh toán khi nhận hàng")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .fontWeight(.medium)
                        .padding(.leading, 10)
                    Spacer()
                }
                .padding(.leading, 30)
                .padding(.vertical, 18)
                .frame(width: UIScreen.main.bounds.width)
                .background(isVnpayButtonSelected ? Color("EBF0FF") : Color.clear)
            }
            Divider().background(Color("EBF0FF"))
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}
struct ChoosePaymentView_Previews: PreviewProvider {
    static var previews: some View {
        ChoosePaymentView(path: .constant(NavigationPath()))
    }
}
