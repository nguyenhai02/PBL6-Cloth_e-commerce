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
    let columns: [GridItem] = Array(repeating: .init(.flexible(minimum: 10, maximum: 170)), count: 2)
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HeadView(searchText: $searchText)
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
            }
            if selectedOption == 0 {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(viewModel.products, id: \.id) { product in
                            ItemRow(path: $path, product: product)
                        }
                    }
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(viewModel.categoryProduct, id: \.id) {
                            product in
                            ItemRow(path: $path, product: product)
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

struct HeadView: View {
    @Binding var searchText: String
    var body: some View {
        Spacer().frame(height: 15)
        HStack {
            HStack(spacing: 0) {
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
                    // action
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black.opacity(0.6))
                }
                .padding(10)
            }
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 6).stroke(.gray))
            .padding([.leading], 10)
            .padding(.horizontal, 25)
            Spacer()
        }
    }
}

struct ShoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingView(path: .constant(NavigationPath()))
    }
}
