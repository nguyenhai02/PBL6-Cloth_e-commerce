//
//  AppApp.swift
//  App
//
//  Created by Thanh Hien on 19/09/2023.
//

import SwiftUI

@main
struct AppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
            LoginView()
        }
//            RegisterView()
//            HomeView(categories: Categories(id: 1, name: "category", description: "ao nam", imageURL: "category"))
//            ItemDetailView(product: Product(id: 1, name: "Womens White Shirt", description: "Reflective design details Fabric: Body: 100% recycled polyester.Lining: 79% polyester/ 21% elastane. Hand wash Imported Not intended for use as Personal Protective Equipment Colour Shown: Volt Style: BV2204-702 Country/Region of Origin: Indonesia", imageURL: "product", price: "100.000", brand: "Brand Name", isFavorite: true))
        }
    }
}
