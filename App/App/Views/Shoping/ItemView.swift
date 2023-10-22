//
//  ItemView.swift
//  App
//
//  Created by Thanh Hien on 21/10/2023.
//

import SwiftUI

struct ItemView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image("product")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 150)
            VStack(alignment: .leading, spacing: 0) {
                Text("Xấu ngâm đường")
                    .font(.system(size: 14))
                    .padding(.top, 10)
                Text("đ65000")
                .font(.system(size: 12))
                .foregroundColor(.red)
                .padding(.top, 5)
                HStack {
                    Text("Đã bán")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    Text("680")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                }
                .padding(.top, 5)
            }
            .padding(.leading, 35)
        }
        .frame(width: 200, height: 250)
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView()
    }
}
