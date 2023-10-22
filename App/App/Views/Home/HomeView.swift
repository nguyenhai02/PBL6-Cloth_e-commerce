//
//  HomeView.swift
//  App
//
//  Created by Thanh Hien on 11/10/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State private var show = false
    @State private var showFavoriteView = false
    @Binding var path : NavigationPath
    
    var body: some View {
        print("stack \(path.count)")
        return VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 7)
                HStack {
                    Button(action: {
                        self.show = true
                    }) {
                        Image("product")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .cornerRadius(35)
                            .padding(.leading, 20)
                    }
                    Text("Hien Nguyen")
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .padding(.leading, 13)
                    Spacer()
                    Button(action: {
                        self.showFavoriteView.toggle()
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
                .navigationDestination(isPresented: $show) {
                    ProfileView(path: $path)
                }
                ScrollView {
                    Spacer().frame(height: 20)
                    ScrollView(.horizontal,showsIndicators: false, content:  {
                        HStack(spacing: 30) {
                            ForEach(viewModel.categories, id: \.id) { categories in
                                CategoriesItem(categories: categories)
                            }
                        }
                    })
                    .padding(.leading, 20)
                    VStack(alignment: .leading, spacing: 0) {
                        ZStack {
                            GeometryReader { geometry in
                                Image("logo3")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width, height: 275)
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
                                .padding(.top, 5)
                                .padding(.leading, 10)
                            ScrollView(.horizontal, showsIndicators: false, content:  {
                                HStack(spacing: 0) {
                                    ForEach(viewModel.product, id: \.id) { product in
                                        ItemRow(product: product)
                                    }
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
                                HStack(spacing: 0) {
                                    ForEach(viewModel.product, id: \.id) { product in
                                        ItemRow(product: product)
                                    }
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
                                HStack(spacing: 0) {
                                    ForEach(viewModel.product, id: \.id) { product in
                                        ItemRow(product: product)
                                    }
                                }
                                .padding(.top, 15)
                            })
                        }
                    }
                }
            }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $showFavoriteView) {
            FavoriteView(path: $path)
        }
    }
}

struct CategoriesItem: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State var show = false
    let categories: Categories
    var body: some View {
            VStack(spacing: 0) {
                Button(action: {
                    
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
                self.show.toggle()
            }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(path: .constant(NavigationPath()))
    }
}
