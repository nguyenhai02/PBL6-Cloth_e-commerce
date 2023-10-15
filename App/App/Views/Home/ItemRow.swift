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
            Spacer().frame(height: 10)
            Image(product.imageURL)
                .resizable().renderingMode(.original)
                .aspectRatio(contentMode: .fill)
//                .frame(width: UIScreen.main.bounds.width / 2 - 30, height: 195)
                .frame(width: 184, height: 245)
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.5), radius: 5, x: 0.3, y: 0.3)
                .overlay (
                    Button(action: {
                        print("action")
                    }) {
                        Image(systemName: product.isFavorite == true ? "heart.fill" : "heart")
                            .foregroundColor(product.isFavorite == true ? .red : .gray)
                            .frame(width: 30, height: 30)
                            .background(Color.white)
                    }
                    .cornerRadius(20)
                    .opacity(0.9)
                    .shadow(color: .gray, radius: 0.5, x: 0.3, y: 0.3)
                    .padding([.top, .trailing], 5)
                    , alignment: .topTrailing
                )
            
           // label
            Group {
                Text(product.name)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(Color("272727"))
                    .padding(.top, 9)
                Text(product.brand)
                    .font(.system(size: 12))
                    .foregroundColor(Color("272727"))
                Text("VND: \(product.price)")
                    .font(.system(size: 12))
                    .foregroundColor(Color("272727"))
            }
            .padding([.horizontal], 5)
        }
//        .frame(width: 20, height: 260)
        .background(Color.clear)
        .padding(.all, 8)
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
        ItemRow(product:  Product(id: 2, name: "Men", description: "Men", imageURL: "product", price: "200", brand: "go chi", isFavorite: true))
    }
}
