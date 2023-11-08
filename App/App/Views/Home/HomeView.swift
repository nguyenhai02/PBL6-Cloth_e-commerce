//
//  HomeView.swift
//  App
//
//  Created by Thanh Hien on 11/10/2023.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @ObservedObject var profileViewModel = ProfileViewModel()
    @Binding var path : NavigationPath
    //    var productDetail: ProductDetail
    
    var body: some View {
        return VStack(alignment: .leading, spacing: 0) {
            Spacer().frame(height: 7)
            HStack {
                Button(action: {
                    path.append("ProfileView")
                }) {
                    KFImage(URL(string: profileViewModel.profile?.avatar ?? ""))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFill()
                        .frame(width: 35, height: 35)
                        .cornerRadius(35)
                        .padding(.leading, 20)
                }
                Text(profileViewModel.profile?.name ?? "")
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .padding(.leading, 13)
                Spacer()
                Button(action: {
                    path.append("FavoriteView")
                }) {
                    Image(systemName: "heart")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 20)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 6)
            ScrollView {
                Spacer().frame(height: 20)
                ScrollView(.horizontal,showsIndicators: false, content:  {
                    HStack(spacing: 30) {
                        ForEach(viewModel.categories, id: \.id) { categories in
                            CategoriesItem(path: $path, viewModel: viewModel, categories: categories)
                        }
                    }
                })
                .padding(.leading, 20)
                VStack(alignment: .leading, spacing: 0) {
                    ZStack {
                        GeometryReader { geometry in
                            Image("logo2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: 275)
                                .clipped()
                        }
                        VStack(spacing: 0) {
                            Image("forever")
                                .padding(.top, 90)
                            Text("Big Fashion Festival")
                                .font(.system(size: 20))
                                .bold()
                                .foregroundColor(.white)
                                .padding(.top, 14)
                            Text("70% - 80% Off")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .padding(.top, 14)
                            Spacer()
                        }
                    }
                    .frame(height: 280)
                    Group {
                        Text("Trending Offers")
                            .font(.system(size: 18))
                            .foregroundColor(Color("272727"))
                            .fontWeight(.medium)
                            .padding(.top, 15)
                            .padding(.leading, 10)
                        ScrollView(.horizontal, showsIndicators: false, content:  {
                            HStack(spacing: 15) {
                                ForEach(viewModel.products, id: \.product.id) { productDetail in
                                    ItemRow(path: $path, product: productDetail)
                                }
                                .padding(.leading, 10)
                                .padding(.top, 15)
                            }
                        })
                        Text("Deals Of The Day")
                            .font(.system(size: 18))
                            .foregroundColor(Color("272727"))
                            .fontWeight(.medium)
                            .padding(.top, 15)
                            .padding(.leading, 10)
                        ScrollView(.horizontal, showsIndicators: false, content:  {
                            HStack(spacing: 15) {
                                ForEach(viewModel.products, id: \.product.id) { productDetail in
                                    ItemRow(path: $path, product: productDetail)
                                }
                                .padding(.leading, 10)
                                .padding(.top, 15)
                            }
                            
                        })
                        Text("Our Collection")
                            .font(.system(size: 18))
                            .foregroundColor(Color("272727"))
                            .fontWeight(.medium)
                            .padding(.top, 15)
                            .padding(.leading, 10)
                        ScrollView(.horizontal, showsIndicators: false, content:  {
                            HStack(spacing: 15) {
                                ForEach(viewModel.products, id: \.product.id) { productDetail in
                                    ItemRow(path: $path, product: productDetail)
                                }
                            }
                            .padding(.leading, 10)
                            .padding(.top, 15)
                        })
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            profileViewModel.showProfile()
        }
    }
}

struct CategoriesItem: View {
    @Binding var path: NavigationPath
    @ObservedObject var viewModel: HomeViewModel
    @State var showView = false
    let categories: Categories
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                viewModel.categoryId = categories.id
                print("viewModel.categoryId")
                print( viewModel.categoryId)
                path.append(CategoryProductView(viewModel: viewModel, path: $path, category: categories))
                print("categories.id")
                print(categories.id)
            }) {
                Image(categories.name.lowercased())
                //                    Image("product")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 62, height: 62)
                    .clipShape(Circle())
            }
            Text(categories.name)
                .foregroundColor(Color("272727"))
                .font(.system(size: 14))
                .padding(.top, 8)
        }
        .onTapGesture {
            self.showView = true
        }
        .navigationDestination(for: CategoryProductView.self) { _ in
            CategoryProductView(viewModel: viewModel, path: $path, category: categories)
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        //        let product = Product(id: 1, name: "Quần áo là quần áo là quần áo", description: "Green printed woven fit and flare dress, has a notched lapel collar and sleevesless.", price: 10, discount: 10, createDate: "1/1/2023", updateDate: "1/2/2023", category: Categories(id: 3, name: "Quần", description: "Quần jeans nam nữ", createDate: "2023-10-21T00:55:48", updateDate: "2023-10-21T00:55:48"))
        //        let productVariants = [ProductVariant(id: 1, color: "red", size: "M", quantity: 40)]
        HomeView(path: .constant(NavigationPath()))
    }
}
