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
                            Text("Home")
                        }.tag(0)
                    ShoppingView(path: $path)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Tìm kiếm")
                        }.tag(1)
                    FavoriteView(path: $path)
                        .tabItem {
                            Image(systemName: "bell.fill")
                            Text("Thông báo")
                        }.tag(2)
                    CartView(path: $path)
                        .tabItem {
                            Image(systemName: "cart")
                            Text("Cart")
                        }.tag(3)
                    SettingView(path: $path)
                        .tabItem {
                            Image(systemName: "person")
                            Text("Setting")
                        }.tag(5)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }


struct TagBarView_Previews: PreviewProvider {
    static var previews: some View {
        TagBarView(path: Binding(get: {NavigationPath()}, set: { _, _ in
            
        }))
    }
}
