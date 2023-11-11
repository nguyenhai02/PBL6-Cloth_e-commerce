//
//  CartView.swift
//  App
//
//  Created by Thanh Hien on 17/10/2023.
//

import SwiftUI
import Kingfisher

struct CartView: View {
    @ObservedObject var viewModel = CartViewModel()
    @Binding var path: NavigationPath
    @State var value = 0
    @State private var isOn = false
    let productDetail: ProductDetail
    var body: some View {
        ZStack {
            Color("CFCFCF").opacity(0.3)
            //            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 0) {
                Text("My cart")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 18))
                    .foregroundColor(.black)
                    .padding([.top, .leading], 20)
                Spacer().frame(height: 10)
                ScrollView {
                    ForEach(viewModel.cartItems, id: \.self) { cartItem in
                        CartItem(viewModel: viewModel, path: $path, product: productDetail, cartItem: cartItem)
                    }
                    .onAppear {
                        viewModel.getCartItems()
                    }
                }
                Spacer()
            }
        }
    }
}
struct CartItem: View {
    @ObservedObject var viewModel: CartViewModel
    @Binding var path: NavigationPath
    let product: ProductDetail
    @State var cartItem: Cart
    @State var value = 0
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                path.append(ItemDetailView(path: $path, productId: cartItem.productId))
            }) {
                KFImage(URL(string: cartItem.image ?? "https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 105)
                    .scaledToFill()
                    .cornerRadius(1)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                HStack   {
                    Text(cartItem.productName)
                        .font(.system(size: 14))
                        .foregroundColor(Color("002482"))
                        .lineLimit(1)
                    Spacer()
                    Button(action: {
                        viewModel.id = cartItem.id
                        viewModel.deleteCartItems()
                        viewModel.getCartItems()
                    }) {
                        Image(systemName: "trash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray)
                            .frame(width: 16, height: 16)
                            .padding(.trailing, 12)
                    }
                }
                .padding(.top, 15)
                //                        Text("Wine Halter Bow")
                //                            .font(.system(size: 14))
                //                            .foregroundColor(.black)
                //                            .padding(.top, 8)
                HStack {
                    Text("Color:")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    Text(cartItem.color)
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.7))
                    
                    Text("Size:")  .font(.system(size: 14))
                        .foregroundColor(.gray)
                    Text(cartItem.size)
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.7))
                }
                .padding(.top, 8)
                HStack(spacing: 0) {
                    Button(action: {
                        if cartItem.quantity > 0 {
                            cartItem.quantity -= 1
                            viewModel.productId = cartItem.productId
                            viewModel.quantity  -= 2
                            viewModel.color = cartItem.color
                            viewModel.size = cartItem.size
                            viewModel.addCart() {}
                        }
                    }) {
                        Image(systemName: "minus")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .frame(width: 32, height: 20)
                            .padding(1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 2).stroke(Color("EBF0FF"), lineWidth: 1))
                    }
                    Text("\(cartItem.quantity)")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                        .frame(width: 32, height: 20)
                        .padding(1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 2).stroke(Color("EBF0FF"), lineWidth: 1))
                        .background(Color("EBF0FF"))
                    Button(action: {
                        cartItem.quantity += 1
                        viewModel.productId = cartItem.productId
                        viewModel.quantity  += 0
                        viewModel.color = cartItem.color
                        viewModel.size = cartItem.size
                        viewModel.addCart() {}
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .frame(width: 28, height: 18)
                            .padding(1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 2).stroke(Color("EBF0FF"), lineWidth: 1))
                    }
                }
                .padding(.vertical, 10)
                .padding(.bottom, 5)
            }
            .padding(.leading, 20)
            .multilineTextAlignment(.leading)
            
        }
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color("F9F9F9"), lineWidth: 1)
                .shadow(color: Color.gray, radius: 10)
        )
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .onAppear {
            viewModel.getCartItems()
        }
    }
}
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(id: 1, name: "Quần áo là quần áo là quần áo", description: "Green printed woven fit and flare dress, has a notched lapel collar and sleevesless.", price: 10, discount: 10, createDate: "1/1/2023", updateDate: "1/2/2023", category: Categories(id: 3, name: "Quần", description: "Quần jeans nam nữ", createDate: "2023-10-21T00:55:48", updateDate: "2023-10-21T00:55:48"))
        let productVariants = [ProductVariant(id: 1, color: "red", size: "M", quantity: 40)]
        CartView(path: .constant(NavigationPath()), productDetail: ProductDetail(product: product, productVariants: productVariants))
    }
}
