//
//  Product.swift
//  App
//
//  Created by Thanh Hien on 21/10/2023.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let name: String
    let description: String
    let price: Int
    let discount: Int
    let quantity: Int
    let createDate: String
    let updateDate: String
}
