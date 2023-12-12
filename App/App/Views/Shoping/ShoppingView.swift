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
    @State var showSlideMenu = false
    let columns: [GridItem] = Array(repeating: .init(.flexible(minimum: 10, maximum: 170)), count: 2)
    var body: some View {
        ZStack(alignment: .trailing){
            NavigationView {
                ZStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer().frame(height: 5)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                Button(action: {
                                    viewModel.categoryId = -1
                                }) {
                                    Text("Tất cả")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color("002482"))
                                        .padding(7)
                                }
                                ForEach(viewModel.categories, id: \.id) { category in
                                    Button(action: {
                                        viewModel.categoryId = category.id
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
                        ScrollView {
                         LazyVGrid(columns: columns, spacing: 15) {
                             ForEach(viewModel.categoryProduct, id: \.self) {
                                 productDetail in
                                 ItemView(path: $path, product: productDetail)
                                     .padding(.leading, 15)
                             }
                         }
                     }
                        Spacer()
                    }
                }
                .navigationBarItems(leading: (
                    HStack {
                        HeadView(showSlideMenu: showSlideMenu, searchText: $searchText) {value in
                            viewModel.searchText = value
                            viewModel.showCategoryProduct()
                        }
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
        .onReceive(viewModel.$categoryId) { value in
            viewModel.showCategoryProduct()
        }
        .onReceive(viewModel.$sort) { _ in
            viewModel.showCategoryProduct()
        }
        .padding(.top, 15)
    }
}

struct HeadView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State var showSlideMenu: Bool
    @Binding var searchText: String
    let onSearch : (String) -> Void
    var body: some View {
        Spacer().frame(height: 25)
        HStack {
            TextField("Tìm kiếm...", text: $searchText)
                .padding([.leading], 10)
                .foregroundColor(.black)
                .onChange(of: searchText) { newValue in
                    viewModel.searchPublicsher.send(newValue)
                }
                .onReceive(viewModel.searchPublicsher
                    .debounce(for: .milliseconds(500) , scheduler: DispatchQueue.main)) { newValue in
                        onSearch(newValue)
                    }
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            
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
                HStack {
                    Button(action: {
                        viewModel.sort = "price,asc"
                        //viewModel.showProduct()
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
                        //viewModel.showProduct()
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
