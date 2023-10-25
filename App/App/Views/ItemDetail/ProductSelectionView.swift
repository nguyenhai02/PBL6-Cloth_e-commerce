//
//  ProductSelectionView.swift
//  App
//
//  Created by Thanh Hien on 24/10/2023.
//

import SwiftUI

struct ProductSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var path: NavigationPath
    @State var value = 1
    let product: Product
    var onPayment: () -> Void
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 10)
            HStack {
                Image("xinh")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("\(product.price)")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .strikethrough()
                        Text("đ\((product.price) - ((product.price) * (product.discount) / 100))")
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
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14)
                        .foregroundColor(.gray)
                        .padding(.trailing, 15)
                }
                .padding(.top, -40)
            }
            .padding(.leading, 30)
            Divider()
            HStack(spacing: 0) {
                Text("Số lượng")
                    .padding(.leading, 20)
                Spacer()
                Button(action: {
                    if value > 0 {
                        value -= 1
                    }
                }) {
                    Image(systemName: "minus")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .frame(width: 32, height: 25)
                        .padding(1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 2).stroke(Color("EBF0FF"), lineWidth: 1))
                }
                Text("\(value)")
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                    .frame(width: 32, height: 25)
                    .padding(1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 2).stroke(Color("EBF0FF"), lineWidth: 1))
                Button(action: {
                    value += 1
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .frame(width: 32, height: 25)
                        .padding(1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 2).stroke(Color("EBF0FF"), lineWidth: 1))
                }
            }
            .padding(.top, 15)
            .padding(.trailing, 15)
            Spacer().frame(height: 170)
            TLButton(title: "Mua ngay", background: Color("002482"), action:  {
                onPayment()
            })
            .padding(.horizontal, 20)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ProductSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProductSelectionView(path: .constant(NavigationPath()), product: Product(id: 1, name: "Quần áo là quần áo là quần áo", description: "Green printed woven fit and flare dress, has a notched lapel collar and sleevesless.", price: 10, discount: 10, createDate: "1/1/2023", updateDate: "1/2/2023", category: Categories(id: 3, name: "Quần", description: "Quần jeans nam nữ", createDate: "2023-10-21T00:55:48", updateDate: "2023-10-21T00:55:48")), onPayment: {})
    }
}
