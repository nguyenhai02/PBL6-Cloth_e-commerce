//
//  ProductSelectionView.swift
//  App
//
//  Created by Thanh Hien on 24/10/2023.
//

import SwiftUI
import Kingfisher

struct ProductSelectionView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: CartViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    //    @Binding var path: NavigationPath
    //    let productDetail: ProductDetail
    let title: String
    var onNext: () -> Void
    var body: some View {
        ZStack {
            Color("F9F9F9")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Spacer().frame(height: 10)
                HStack {
                    KFImage(URL(string: homeViewModel.productDetail?.product.image ?? ""))
                    //                Image("xinh")
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("\(homeViewModel.productDetail?.product.price ?? 0)")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                                .strikethrough()
                            Text("đ\((homeViewModel.productDetail?.product.price ?? 0) - ((homeViewModel.productDetail?.product.price ?? 0) * (homeViewModel.productDetail?.product.discount ?? 0) / 100))")
                                .font(.system(size: 16))
                                .foregroundColor(.red)
                        }
                        GetQuantity(viewModel: viewModel, homeViewModel: homeViewModel)
                        
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
                        if  viewModel.quantity > 0 {
                            viewModel.quantity -= 1
                            print(viewModel.quantity)
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
                    Text("\(viewModel.quantity)")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                        .frame(width: 32, height: 25)
                        .padding(1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 2).stroke(Color("EBF0FF"), lineWidth: 1))
                    Button(action: {
                        viewModel.quantity += 1
                        print( viewModel.quantity)
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
                TLButton(title: title, background: Color("002482"), action:  {
                    print( viewModel.quantity)
                    onNext()
                })
                .padding(.horizontal, 20)
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct GetQuantity: View {
    @ObservedObject var viewModel:CartViewModel
    @ObservedObject var homeViewModel: HomeViewModel
    var body: some View  {
        VStack {
            if let variantsForSelectedColorAndSize = homeViewModel.productDetail?.productVariants.filter({ $0.color == viewModel.color && $0.size == viewModel.size}) {
                if  let quantity = variantsForSelectedColorAndSize.first?.quantity {
                    Text("Số lượng: \(quantity)")
                        .font(.system(size: 16))
                        .foregroundColor(.black.opacity(0.8))
                        .padding(.top, 5)
                } else {
                    Text("Số lượng: 0")
                        .font(.system(size: 16))
                        .foregroundColor(.black.opacity(0.8))
                        .padding(.top, 5)
                }
            } else {
                Text("Số lượng: 0")
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.8))
                    .padding(.top, 5)
            }
        }
    }
}

struct ProductSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(id: 1, name: "Quần áo là quần áo là quần áo", description: "Green printed woven fit and flare dress, has a notched lapel collar and sleevesless.", discount: 10, price: 10, createDate: "1/1/2023", updateDate: "1/2/2023", category: Categories(id: 3, name: "Quần", description: "Quần jeans nam nữ", createDate: "2023-10-21T00:55:48", updateDate: "2023-10-21T00:55:48"))
        let categories = Categories(id: 3, name: "Quần", description: "Quần jeans nam nữ", createDate: "2023-10-21T00:55:48", updateDate: "2023-10-21T00:55:48")
        let productVariants = [ProductVariant(id: 1, color: "red", size: "M", quantity: 40)]
        ProductSelectionView(viewModel: CartViewModel(), homeViewModel: HomeViewModel(), title: "", onNext: {})
        ProductSelectionView(viewModel: CartViewModel(), homeViewModel: HomeViewModel(), title: "", onNext: {})
    }
}

