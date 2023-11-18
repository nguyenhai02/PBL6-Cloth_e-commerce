//
//  Cart.swift
//  App
//
//  Created by Thanh Hien on 04/11/2023.
//

import Foundation

struct Cart: Decodable, Hashable {
//    var idProduct: String = UUID().uuidString
    let id: Int
    let productId: Int
    let productName: String
    let image: String?
    let color: String
    let size: String
    var price: Double
    var quantity: Int
}
