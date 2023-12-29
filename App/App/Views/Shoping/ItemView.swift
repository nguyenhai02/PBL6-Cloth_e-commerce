//
//  ItemRow.swift
//  App
//
//  Created by Thanh Hien on 13/10/2023.
//

import SwiftUI
import Kingfisher

struct ItemView: View {
    @EnvironmentObject var dataStore: DataStore
    @ObservedObject var loadImageviewModel = LoadImage()
    @ObservedObject var viewModel = HomeViewModel()
    @ObservedObject var  favouriteViewModel = FavouriteViewModel.instance
    @Binding var path: NavigationPath
    var product: ProductDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            KFImage(URL(string: product.product.image ?? "https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg"))
                .setProcessor(ResizingImageProcessor(referenceSize: CGSize(width:  160, height: 180)) |> RoundCornerImageProcessor(cornerRadius: 8))
                .loadDiskFileSynchronously()
                .overlay (
                    Button(action: {
                        let favouriteItem = favouriteViewModel.favouriteItems.first(where: { $0.product.id == product.product.id})
                        if favouriteItem == nil {
                            favouriteViewModel.id =  product.product.id
                            favouriteViewModel.addFavouriteProduct()
                        } else {
                            if let id = favouriteItem?.id {
                                favouriteViewModel.idFavourite = id
                                favouriteViewModel.deleteFavouirteItem()
                            }
                        }
                    }) {
                        let isFavorite = favouriteViewModel.favouriteItems.contains(where: {
                            $0.product.id == product.product.id
                        })
                        isFavorite ? Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .frame(width: 30, height: 30)
                            .background(Color.white)
                        : Image(systemName:"heart")
                            .foregroundColor(.gray)
                            .frame(width: 30, height: 30)
                            .background(Color.white)
                    }
                        .cornerRadius(20)
                        .opacity(0.9)
                        .shadow(color: .gray, radius: 0.5, x: 0.3, y: 0.3)
                        .padding([.top, .trailing], 8)
                    , alignment: .topTrailing)
            // label
            Group {
                Text(product.product.name)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(Color("272727"))
                    .padding(.top, 9)
                    .padding([.horizontal], 10)
                HStack {
//                    Text("đ\((product.product.price) - ((product.product.price) * (product.product.discount ?? 0) ?? 0 / 100))")
//                    Text("đ\((product.product.price) - ((product.product.price) * (product.product.discount ?? 0) / 100))")
//                        .font(.system(size: 12))
//                        .foregroundColor(.red)
                    Text("đ\(product.product.price) VNĐ")
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                }
                .padding([.leading], 10)
                .padding(.top, 5)
                .padding(.bottom, 10)
//                HStack {
//                    Text("Đã bán")
//                        .font(.system(size: 12))
//                        .foregroundColor(.black)
//                    Text("680")
//                        .font(.system(size: 12))
//                        .foregroundColor(.black)
//                }
//                .padding(.top, 5)
//                .padding([.horizontal], 10)
            }
            .padding([.horizontal], 5)
        }
        .frame(width: 160, height: 235)
        .overlay(
            RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 0.5)).clipped()
            .onTapGesture {
                dataStore.selectedProduct = product
                path.append(ItemDetailView(path: $path, productId: product.product.id))
            }
            .navigationDestination(for: ItemDetailView.self) { product in
                ItemDetailView(path: $path, productId: product.productId)
            }
            .onAppear {
                viewModel.id =  product.product.id
                viewModel.getProductDetail()
                favouriteViewModel.getFavouriteProduct()
                loadImageviewModel.loadImage(from: product.product.image ?? "https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg") {
                    print("Hình ảnh đã được tải thành công")
                    if let imageURL = product.product.image {
                        dataStore.imageURL = imageURL
                }
            }
        }
    }
}


struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(id: 1, name: "Quần áo là quần áo là quần áo", description: "Green printed woven fit and flare dress, has a notched lapel collar and sleevesless.", discount: 10, price: 10, createDate: "1/1/2023", updateDate: "1/2/2023", category: Categories(id: 3, name: "Quần", description: "Quần jeans nam nữ", createDate: "2023-10-21T00:55:48", updateDate: "2023-10-21T00:55:48"))
        let productVariants = [ProductVariant(id: 1, color: "red", size: "M", quantity: 40)]
        ItemRow(path: .constant(NavigationPath()), product: ProductDetail(product: product, productVariants: productVariants))
    }
}
