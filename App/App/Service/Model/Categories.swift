//
//  Categories.swift
//  App
//
//  Created by Thanh Hien on 15/10/2023.
//

import Foundation

struct Categories: Decodable {
    let id: Int
    let name: String
    let description: String
    let createDate: String
    let updateDate: String
}

//extension Categories {
//    static func all() -> [Categories] {
//        return [
//            Categories(id: 1, name: "Categories", description: "Categories", createDate: "2023-10-15T00:39:29", updateDate: "2023-10-15T00:39:29"),
//            Categories(id: 2, name: "Men", description: "Men", createDate: "2023-10-15T00:39:29", updateDate: "2023-10-15T00:39:29"),
//            Categories(id: 3, name: "Woman", description: "Woman",createDate: "2023-10-15T00:39:29", updateDate: "2023-10-15T00:39:29")
////            Categories(id: 4, name: "Kids", description: "Kids", imageURL: "kids"),
////            Categories(id: 5, name: "Kids", description: "Kids", imageURL: "kids"),
////            Categories(id: 6, name: "Kids", description: "Kids", imageURL: "kids"),
////            Categories(id: 7, name: "Kids", description: "Kids", imageURL: "kids"),
//        ]
//        
//    }
//    
//}
