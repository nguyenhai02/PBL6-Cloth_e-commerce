//
//  SuccesCODView.swift
//  App
//
//  Created by Thanh Hien on 09/12/2023.
//

import SwiftUI

struct SuccessCODView: View {
    @Binding var path: NavigationPath
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                Button(action: {
                    path.append("TagBarView")
                }) {
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("DA2F23"))
                }
            }
                .padding(.trailing, 20)
                .padding(.top, 5)
            Spacer().frame(height: 120)
            Image("success")
                .resizable()
                .frame(width: 180, height: 180)
                .aspectRatio(contentMode: .fit)
            Text("Đặt hàng thành công!")
                .font(.system(size: 20))
                .padding(.vertical, 10)
            Text("Cảm ơn bạn đã lựa chọn chúng tôi! Đơn hàng của bạn đã được ghi nhận và đang trong quá trình chờ xác nhận.")
                .font(.system(size: 14))
                .foregroundColor(.black)
                .frame(width: 330)
                .multilineTextAlignment(.center)
//                .padding(.top, 5)
          
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SuccesCODView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessCODView(path: .constant(NavigationPath()))
    }
}
