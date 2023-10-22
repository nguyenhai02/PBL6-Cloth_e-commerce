//
//  ItemRow.swift
//  App
//
//  Created by Thanh Hien on 13/10/2023.
//

import SwiftUI

struct ItemRow: View {
    @State var show = false
    var product: Product
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image("product")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 190)
                .cornerRadius(8)
                .overlay (
                    Button(action: {
                        print("action")
                    }) {
                        Image(systemName: "heart")
//                        Image(systemName: product.isFavorite == true ? "heart.fill" : "heart")
//                            .foregroundColor(product.isFavorite == true ? .red : .gray)
                            .foregroundColor(.gray)
                            .frame(width: 30, height: 30)
                            .background(Color.white)
                    }
                        .cornerRadius(20)
                        .opacity(0.9)
                        .shadow(color: .gray, radius: 0.5, x: 0.3, y: 0.3)
                        .padding([.top, .trailing], 8)
                    , alignment: .topTrailing
                )
            
            // label
            Group {
                Text(product.name)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(Color("272727"))
                    .padding(.top, 9)
                    .padding([.horizontal], 10)
//                Text(product.brand)
//                    .font(.system(size: 12))
//                    .foregroundColor(.gray)
//                    .padding(.leading, 5)
                HStack {
                    Text("đ\(product.price - (product.price * product.discount)/100)")
                        .font(.system(size: 12))
                        .foregroundColor(.red)
//                    Text("đ\(product.price)")
//                        .font(.system(size: 10))
//                        .strikethrough()
                    Text("\(product.discount)% OFF")
                        .font(.system(size: 11))
                        .foregroundColor(Color("002482"))
                }
                .padding([.leading], 10)
                .padding(.top, 5)
                HStack {
                    Text("Đã bán")
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    Text("680")
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                }
                .padding(.top, 5)
                .padding(.bottom, 10)
                .padding([.horizontal], 10)
            }
            .padding([.horizontal], 5)
        }
        .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 260)
        .overlay(
            RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1).shadow(radius: 2))
        .padding(.leading, 20)
        .clipped()
        .onTapGesture {
            self.show.toggle()
        }.navigationDestination(isPresented: $show) {
            ItemDetailView(product: product)
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(product:  Product(id: 1, name: "Quần áo", description: " quần áo", price: 10000000, discount: 10, quantity: 1, createDate: "1/1/2023", updateDate: "1/2/2023"))
    }
}
