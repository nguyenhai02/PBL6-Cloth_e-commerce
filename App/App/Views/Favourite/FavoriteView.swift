//
//  FavoriteView.swift
//  App
//
//  Created by Thanh Hien on 17/10/2023.
//

import SwiftUI
import Kingfisher

struct FavoriteView: View {
    @ObservedObject var viewModel = FavouriteViewModel.instance
    @Binding var path: NavigationPath
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button(action: {
                    path.removeLast()
                }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 22, height: 18)
                        .padding(.leading, 25)
                    Text("Yêu thích")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.top, 15)
            }
            Spacer().frame(height: 20)
            ScrollView {
                if viewModel.favouriteItems == [] {
                    HStack(alignment: .center) {
                        LottieView(lottieFile: "favourite")
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                }
                ForEach(viewModel.favouriteItems, id: \.self) { favouriteItem in
                    Button(action: {
                        path.append(ItemDetailView(path: $path, productId: favouriteItem.id))
                    }) {
                        HStack {
                            KFImage(URL(string: favouriteItem.product.image ?? ""))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 72, height: 78)
                                .padding(.top, 10)
                                .padding(.leading, 20)
                            VStack(alignment: .leading, spacing: 0) {
                                Text(favouriteItem.product.name)
                                    .bold()
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("002482"))
                                    .lineLimit(2)
                                Text("Wine Halter Bow ")
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                                    .padding(.top, 5)
                                HStack {
                                    Text("đ\((favouriteItem.product.price ) - ((favouriteItem.product.price ) * (favouriteItem.product.discount ) / 100))")
                                        .font(.system(size: 10))
                                        .foregroundColor(.black)
                                    Text("VND: \(favouriteItem.product.price )")
                                        .font(.system(size: 10))
                                        .foregroundColor(.black)
                                        .strikethrough()
                                    Text("\(favouriteItem.product.discount )% OFF")
                                        .font(.system(size: 10))
                                        .foregroundColor(.red)
                                    }
                                .padding(.top, 5)
                            }
                            .padding(.leading, 15)
                        }
                        .navigationDestination(for: ItemDetailView.self) {_ in
                            ItemDetailView(path: $path, productId: favouriteItem.id)
                        }
                        Spacer()
                        VStack {
                            Button(action: {
                                viewModel.idFavourite = favouriteItem.id
                                viewModel.deleteFavouirteItem()
                            }) {
                                Image(systemName: "multiply")
                                    .foregroundColor(.gray)
                                    .frame(width: 30, height: 30)
                            }
                            .padding(.trailing, 10)
                        }
                    }
                    Divider()
                        .padding(.horizontal, 20)
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.getFavouriteProduct()
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(path: .constant(NavigationPath()))
    }
}


