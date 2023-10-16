//
//  HomeView.swift
//  App
//
//  Created by Thanh Hien on 11/10/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    let categories: Categories
    let arrProduct = Product.all()
    //    @State var show = false   
    
    @State var searchText: String = ""
    var body: some View {
        return VStack(alignment: .leading, spacing: 0) {
                Spacer().frame(height: 7)
                HStack {
                    Image("girl")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .cornerRadius(35)
                        .padding(.leading, 20)
                    Text("Anna Doe")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .padding(.leading, 13)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 6)
                ScrollView {
                    Spacer().frame(height: 10)
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
                                    ForEach(self.arrProduct, id: \.id) { product in
                                        ItemRow(product: product)
                                    }
                                }
                            })
                            Text("Deals Of The Day")
                                .font(.system(size: 18))
                                .foregroundColor(Color("272727"))
                                .fontWeight(.medium)
                                .padding(.top, 5)
                                .padding(.leading, 10)
                            ScrollView(.horizontal, showsIndicators: false, content:  {
                                HStack() {
                                    ForEach(self.arrProduct, id: \.id) { product in
                                        ItemRow(product: product)
                                    }
                                }
                            })
                            Text("Our Collection")
                                .font(.system(size: 18))
                                .foregroundColor(Color("272727"))
                                .fontWeight(.medium)
                                .padding(.top, 5)
                                .padding(.leading, 10)
                            ScrollView(.horizontal, showsIndicators: false, content:  {
                                HStack() {
                                    ForEach(self.arrProduct, id: \.id) { product in
                                        ItemRow(product: product)
                                    }
                                }
                            })
                        }
                    }
                }
            }
        .navigationBarBackButtonHidden(true)
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
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
//                        .padding(10)
//                        .overlay(Circle().stroke(.gray.opacity(0.5), lineWidth: 0.5))
//                        .shadow(color: Color("272727"), radius: 0.5)
                }
                Text(categories.name)
                    .foregroundColor(Color("272727"))
                    .font(.system(size: 14))
                    .padding(.top, 10)
            }
            .onTapGesture {
                self.show.toggle()
            }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView( categories: Categories(id: 1, name: "category", description: "ao nam", createDate: "11/11/2002", updateDate: "11/11/2002"))
    }
}
