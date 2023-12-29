//
//  TagBarView.swift
//  App
//
//  Created by Thanh Hien on 11/10/2023.
//

import SwiftUI

struct TagBarView: View {
    @State var selected = 0
    @Binding var path : NavigationPath
    
    var body: some View {
            VStack {
                TabView(selection: $selected) {
                    HomeView(path: $path)
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Trang chủ")
                        }.tag(0)
                    ShoppingView(path: $path)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Tìm kiếm")
                        }.tag(1)
                    FavoriteView(path: $path)
                        .tabItem {
                            Image(systemName: "heart")
                            Text("Yêu thích")
//                            Image(systemName: "bell.fill")
//                            Text("Thông báo")
                        }.tag(2)
                    CartView(path: $path, productDetail: ProductDetail(product: Product(id: 1, name: "Quần áo là quần áo là quần áo", description: "Green printed woven fit and flare dress, has a notched lapel collar and sleevesless.", discount: 10, price: 10, createDate: "1/1/2023", updateDate: "1/2/2023", category: Categories(id: 3, name: "Quần", description: "Quần jeans nam nữ", createDate: "2023-10-21T00:55:48", updateDate: "2023-10-21T00:55:48")), productVariants: [ProductVariant(id: 1, color: "red", size: "M", quantity: 40)]))
                        .tabItem {
                            Image(systemName: "cart")
                            Text("Giỏ hàng")
                        }.tag(3)
                    SettingView(path: $path)
                        .tabItem {
                            Image(systemName: "person")
                            Text("Cài đặt")
                        }.tag(5)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }


struct TagBarView_Previews: PreviewProvider {
    static var previews: some View {
        TagBarView(path: .constant(NavigationPath()))
    }
}
