//
//  ShoppingView.swift
//  App
//
//  Created by Thanh Hien on 18/10/2023.
//

import SwiftUI

struct ShoppingView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @Binding var path: NavigationPath
    @State var searchText: String = ""
    @State var selectedOption = 0
    @State var showSlideMenu = false
    let columns: [GridItem] = Array(repeating: .init(.flexible(minimum: 10, maximum: 170)), count: 2)
    var body: some View {
        ZStack(alignment: .trailing){
            NavigationView {
                ZStack {
                    //                Color("F9F9F9")
                    //            Color.black
                    //                    .edgesIgnoringSafeArea(.all)
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer().frame(height: 5)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                Button(action: {
                                    self.selectedOption = 0
                                }) {
                                    Text("Tất cả")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color("002482"))
                                        .padding(7)
                                }
                                ForEach(viewModel.categories, id: \.id) { category in
                                    Button(action: {
                                        self.selectedOption = 1
                                        viewModel.showCategoryProduct(categoryId: category.id)
                                        print(category.id)
                                        print("category.id")
                                    }) {
                                        Text(category.name)
                                            .font(.system(size: 16))
                                            .foregroundColor(Color("002482"))
                                            .padding(7)
                                    }
                                }
                            }
                            .padding(.leading, 20)
                            .padding(.vertical, 10)
                            .background(.white)
                        }
                        if selectedOption == 0 {
                            ScrollView {
                                LazyVGrid(columns: columns, spacing: 15) {
                                    ForEach(viewModel.products, id: \.self) { productDetail in
                                        ItemRow(path: $path, product: productDetail)
                                            .padding(.leading, 15)
                                            .background(.white)
                                    }
                                }
                            }
                        } else if selectedOption == 1{
                            ScrollView {
                                LazyVGrid(columns: columns, spacing: 15) {
                                    ForEach(viewModel.categoryProduct, id: \.self) {
                                        productDetail in
                                        ItemRow(path: $path, product: productDetail)
                                    }
                                }
                            }
                        } else {
                            ScrollView {
                                LazyVGrid(columns: columns, spacing: 15) {
                                    ForEach(viewModel.categoryProductByName, id: \.self) { productDetail in
                                        ItemRow(path: $path, product: productDetail)
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
                .navigationBarItems(leading: (
                    HStack {
                        HeadView(showSlideMenu: showSlideMenu, searchText: $searchText) {
                            viewModel.searchByName(text: searchText)
                            self.selectedOption = 3
                        }
                        //                    Text("HIHI")
                        Button(action: {
                            withAnimation {
                                self.showSlideMenu.toggle()
                            }
                        }) {
                            Image("filter")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        Spacer()
                    }
                ))
                .background(.white)
            }
            if(showSlideMenu){
                navigationView
            }
        }
        .padding(.top, 15) 
    }
}

struct HeadView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State var showSlideMenu: Bool
    @Binding var searchText: String
    let onSearch : () -> Void
    var body: some View {
        Spacer().frame(height: 25)
        HStack {
            TextField("Tìm kiếm...", text: $searchText)
                .padding([.leading], 10)
                .foregroundColor(.black)
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            Button(action: {
                onSearch()
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color("002482").opacity(0.5))
            }
            .padding(10)
          
        }
        .frame(width: 300 , height: 40)
        .overlay(
            RoundedRectangle(cornerRadius: 6).stroke(Color("002482").opacity(0.5))).shadow(radius: 0)
            .background(.white)
            .padding([.leading], 30)
            .padding(.trailing, 15)
    }
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView(path: .constant(NavigationPath()))
    }
}

extension ShoppingView {
    var navigationView : some View {
        ZStack {
            Color("F9F9F9")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Button(action: {
                    withAnimation {
                        showSlideMenu = false
                    }
                }) {
                    HStack {
                        Text("Bộ lọc tìm kiếm")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                            .padding([.top, .leading], 15)
                        Spacer()
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .padding(.trailing, 15)
                    }
                }
                Text("Theo giá tiền")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .padding([.top, .leading], 15)
                    .padding(.bottom, 10)
//                Divider()
//                    .background(Color.white)
                HStack {
                    Button(action: {
                        viewModel.sort = "price,asc"
                        viewModel.showProduct()
                        showSlideMenu = false
                    }) {
                        HStack{
                            Text("Giá tăng dần")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: 120, height: 50)
                    .background(Color.white)
                    .padding(.leading, 15)
                    Spacer()
                    Button(action: {
                        viewModel.sort = "price,desc"
                        viewModel.showProduct()
                        showSlideMenu = false
                    }) {
                        HStack{
                            Text("Giá giảm dần")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: 120, height: 50)
                    .background(Color.white)
                    .padding(.trailing, 20)
                }
                Spacer()
            }
        }.frame(width: 300).transition(.move(edge: .trailing))
    }
}
