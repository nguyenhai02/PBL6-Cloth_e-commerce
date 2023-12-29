//
//  DetailOder.swift
//  App
//
//  Created by Thanh Hien on 27/12/2023.
//

import SwiftUI
import Kingfisher

struct DetailOrder: View {
    let image: String
    let name: String
    let price: Int
    let quantity: Int
    let color: String
    let size: String
    var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    VStack {
                        KFImage(URL(string: image))
                                .resizable()
                                .frame(width: 80, height: 80)
    //                            .padding(.leading, 15)
                        Spacer()
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        Text(name)
                            .font(.system(size: 15))
                            .padding(.leading, 10)
                            .padding(.top, 5)
                        HStack {
                            Text("Màu: \(color)")
                                .font(.system(size: 12))
                                .padding(.leading, 10)
                            Text("Size: \(size)")
                                .font(.system(size: 12))
                                .padding(.leading, 30)
//                                .padding(.trailing, 30)
                        }
                        .padding(.top, 8)
                        HStack {
                            Text("đ \(price)")
                                .font(.system(size: 12))
                                .foregroundColor(.red)
                                .padding(.leading, 10)
                            Spacer()
                            Text("x\(quantity)")
                                .font(.system(size: 12))
//                                .padding(.trailing, 30)
                        }
                        .padding(.top, 8)
                        Spacer()
                    }
                    Spacer()
                }
        }
    }
}

struct DetailOder_Previews: PreviewProvider {
    static var previews: some View {
        DetailOrder(image: "https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg", name: "Trang phục lịch sự", price: 200000, quantity: 1, color: "đen", size: "M")
    }
}
