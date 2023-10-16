//
//  Product.swift
//  App
//
//  Created by Thanh Hien on 13/10/2023.
//

import Foundation

struct Product: Identifiable {
    let id: Int
    let name: String
    let description: String
    let imageURL: String
    let price: String
    let brand: String
    let isFavorite: Bool
}

extension Product {
    static func all() -> [Product] {
        return [
            Product(id: 1, name: "Womens White Shirt", description: "Categories", imageURL: "product", price: "100.000", brand: "Brand Name", isFavorite: true),
            Product(id: 2, name: "Womens White Shirt", description: "Categories", imageURL: "product", price: "100.000", brand: "Brand Name", isFavorite: true),
            Product(id: 3, name: "Womens White Shirt", description: "Categories", imageURL: "product", price: "100.000", brand: "Brand Name", isFavorite: true),
            Product(id: 4, name: "Womens White Shirt", description: "Categories", imageURL: "product", price: "100.000", brand: "Brand Name", isFavorite: true),
            Product(id: 5, name: "Womens White Shirt", description: "Categories", imageURL: "product", price: "100.000", brand: "Brand Name", isFavorite: true),
            Product(id: 6, name: "Womens White Shirt", description: "Categories", imageURL: "product", price: "100.000", brand: "Brand Name", isFavorite: true),
            Product(id: 7, name: "Categories", description: "Categories", imageURL: "product", price: "100.000", brand: "go chì", isFavorite: true)
          
           
        ]
        
    }
    
}
