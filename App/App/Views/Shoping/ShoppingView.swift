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
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                HeadView(searchText: $searchText)
                Spacer().frame(height: 5)
                HStack {
                    Spacer()
                    Button(action: {
                        self.selectedOption = 0
                    }) {
                        Text("Liên quan")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                    VStack {
                        Rectangle()
                            .frame(width: 1, height: 20)
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                    }
                    Button(action: {
                        self.selectedOption = 0
                    }) {
                        Text("Mới nhất")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
//                            .padding(.leading, 20)
                    }
                    VStack {
                        Rectangle()
                            .frame(width: 1, height: 20)
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                    }
                    Button(action: {
                        self.selectedOption = 1
                    }) {
                        Text("Bán chạy")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    VStack {
                        Rectangle()
                            .frame(width: 1, height: 20)
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                    }
                    Button(action: {
                        self.selectedOption = 2
                    }) {
                        Text("giá")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                    }
                    Spacer()
                }
                .padding(10)
                Divider().shadow(radius: 10)
                Spacer()
                ScrollView {
                    ZStack {
                        Color("F9F9F9")
                            .edgesIgnoringSafeArea(.all)
                        if selectedOption == 0 {
                            LazyVGrid(columns: [
                                GridItem(.flexible(), spacing: 0),
                                GridItem(.flexible(), spacing: 0)
                            ], spacing: 15)  {
                                ForEach(viewModel.product, id: \.id) { product in
                                    ItemRow(product: product)
                                }
                            }
                        }
                    }
                }
                
        }
    }
}

struct HeadView: View {
    @Binding var searchText: String
    var body: some View {
        Spacer().frame(height: 15)
        HStack {
//            Button(action: {
//
//            }) {
//                Image(systemName: "arrow.left")
//                    .resizable()
//                    .foregroundColor(.gray)
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 20, height: 20)
//                    .padding(.leading, 15)
//            }
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
//            .background(Color(.systemGray6))
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
