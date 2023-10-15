//
//  TagBarView.swift
//  App
//
//  Created by Thanh Hien on 11/10/2023.
//

import SwiftUI

struct TagBarView: View {
    @State var selected = 0
    var body: some View {
            VStack {
                TabView(selection: $selected) {
                    HomeView(categories: Categories(id: 1, name: "category", description: "ao nam", createDate: "11.11.11", updateDate: "11.11.11"))
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }.tag(0)
                    HomeView(categories: Categories(id: 1, name: "category", description: "ao nam", createDate: "11.11.11", updateDate: "11.11.11"))
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Tìm kiếm")
                        }.tag(1)
                    HomeView(categories: Categories(id: 1, name: "category", description: "ao nam", createDate: "11.11.11", updateDate: "11.11.11"))
                        .tabItem {
                            Image(systemName: "heart")
                            Text("Yêu thích")
                        }.tag(2)
                    HomeView(categories: Categories(id: 1, name: "category", description: "ao nam", createDate: "11.11.11", updateDate: "11.11.11"))
                        .tabItem {
                            Image(systemName: "bag")
                            Text("Cart")
                        }.tag(3)
                    HomeView(categories: Categories(id: 1, name: "category",  description: "ao nam", createDate: "11.11.11", updateDate: "11.11.11"))
                        .tabItem {
                            Image("person")
                            Text("Profile")
                        }.tag(5)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }


struct TagBarView_Previews: PreviewProvider {
    static var previews: some View {
        TagBarView()
    }
}
