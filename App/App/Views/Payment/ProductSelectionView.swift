//
//  ProductSelectionView.swift
//  App
//
//  Created by Thanh Hien on 22/10/2023.
//

import SwiftUI

struct ProductSelectionView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 30)
            HStack {
                Image("xinh")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .padding(.leading,30)
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("đ26.000.000")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .strikethrough()
                        Text("đ26.000.000")
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                    }
                    Text("Kho: 200")
                        .font(.system(size: 16))
                        .foregroundColor(.black.opacity(0.8))
                        .padding(.top, 5)
                    
                }
                .padding(.leading, 15)
                Spacer()
            }
            Spacer()
        }
    }
}

struct ProductSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProductSelectionView()
    }
}
