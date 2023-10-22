//
//  Product.swift
//  App
//
//  Created by Thanh Hien on 13/10/2023.
//

import Foundation

struct Product1: Identifiable {
    let id: Int
    let name: String
    let description: String
    let imageURL: String
    let price: Int
    let brand: String
    let isFavorite: Bool
    let discount: Int
}

//extension Product1 {
//    static func all() -> [Product1] {
//        return [
//            Product(id: 1, name: "Womens White Shirt", description: "Reflective design details Fabric: Body: 100% recycled polyester.Lining: 79% polyester/ 21% elastane. Hand wash Imported Not intended for use as Personal Protective Equipment Colour Shown: Volt Style: BV2204-702 Country/Region of Origin: Indonesia", imageURL: "product", price: 100000, brand: "Brand Name", isFavorite: true, discount: 40),
//            Product(id: 2, name: "Womens White Shirt", description: "Reflective design details Fabric: Body: 100% recycled polyester.Lining: 79% polyester/ 21% elastane. Hand wash Imported Not intended for use as Personal Protective Equipment Colour Shown: Volt Style: BV2204-702 Country/Region of Origin: Indonesia", imageURL: "product", price: 100000, brand: "Brand Name", isFavorite: true, discount: 40),
//            Product(id: 3, name: "Womens White Shirt", description: "Reflective design details Fabric: Body: 100% recycled polyester.Lining: 79% polyester/ 21% elastane. Hand wash Imported Not intended for use as Personal Protective Equipment Colour Shown: Volt Style: BV2204-702 Country/Region of Origin: Indonesia", imageURL: "product", price: 100000, brand: "Brand Name", isFavorite: true, discount: 40),
//            Product(id: 4, name: "Womens White Shirt", description: "Reflective design details Fabric: Body: 100% recycled polyester.Lining: 79% polyester/ 21% elastane. Hand wash Imported Not intended for use as Personal Protective Equipment Colour Shown: Volt Style: BV2204-702 Country/Region of Origin: Indonesia", imageURL: "product", price: 100000, brand: "Brand Name", isFavorite: true, discount: 40),
//            Product(id: 5, name: "Womens White Shirt", description: "Reflective design details Fabric: Body: 100% recycled polyester.Lining: 79% polyester/ 21% elastane. Hand wash Imported Not intended for use as Personal Protective Equipment Colour Shown: Volt Style: BV2204-702 Country/Region of Origin: Indonesia", imageURL: "product", price: 100000, brand: "Brand Name", isFavorite: true, discount: 40),
//            Product(id: 6, name: "Womens White Shirt", description: "Reflective design details Fabric: Body: 100% recycled polyester.Lining: 79% polyester/ 21% elastane. Hand wash Imported Not intended for use as Personal Protective Equipment Colour Shown: Volt Style: BV2204-702 Country/Region of Origin: Indonesia", imageURL: "product", price: 100000, brand: "Brand Name", isFavorite: true, discount: 40),
//            Product(id: 7, name: "Womens White Shirt", description: "Reflective design details Fabric: Body: 100% recycled polyester.Lining: 79% polyester/ 21% elastane. Hand wash Imported Not intended for use as Personal Protective Equipment Colour Shown: Volt Style: BV2204-702 Country/Region of Origin: Indonesia", imageURL: "product", price: 100000, brand: "Brand Name", isFavorite: true, discount: 40),
//
//
//        ]
//
//    }
//
//}
