//
//  NotificationView.swift
//  App
//
//  Created by Thanh Hien on 23/10/2023.
//

import SwiftUI

struct NotificationView: View {
    @Binding var path: NavigationPath
    var body: some View {
        ZStack(alignment: .trailing){
            Color.white
                .edgesIgnoringSafeArea(.all)
        VStack(spacing: 0) {
                Spacer().frame(height: 19)
                Text("Thông báo")
                    .font(.system(size: 22))
                    .fontWeight(.medium)
                    .padding(.leading, 15)
                Spacer().frame(height: 10)
                ScrollView  {
                    Spacer().frame(height: 20)
                    ForEach(1..<10) { _ in
                        NotificationRow()
                    }
                }
            }
        }
    }
}
struct NotificationRow: View {
    var body: some View {
        Button(action:{
            // action
        }) {
            HStack {
                Image("xinh")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .padding(.leading, 20)
                VStack(alignment: .leading, spacing: 0) {
                    Text("Đơn hàng đã hoàn tất")
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                        .padding(.top, 10)
                    Text("Đơn hàng 245789900 đã hoàn thành")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 8)
                    Text("10:00 10-11-2023")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                }
                .padding(.leading, 20)
                .padding(.bottom, 5)
                Spacer()
            }
        }
        VStack { Divider() }
        
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(path: .constant(NavigationPath()))
    }
}
