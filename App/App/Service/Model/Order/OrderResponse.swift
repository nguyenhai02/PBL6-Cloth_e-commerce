//
//  OrderResponse.swift
//  App
//
//  Created by Thanh Hien on 18/11/2023.
//

import Foundation

struct OrderResponse: Decodable, Hashable {
    let order: Order
    let orderItems: [OrderItem]
}
struct Order: Decodable, Hashable {
    let id: Int
     let orderDate: String
     let totalPrice: Int
     let paymentMethod, status: String
     let user: User
     let addressDelivery: String
}
struct User: Decodable, Hashable {
    let id: Int
    let name, email: String
    let gender: String?
    let avatar: String?
    let address, phone, role: String
    let enabled: Bool
    let username: String
    let authorities: [Authority]
    let accountNonExpired, accountNonLocked, credentialsNonExpired: Bool
}

struct Authority:  Decodable, Hashable {
    let authority: String
}

struct OrderItem:  Decodable, Hashable {
    let product: Product
    let productVariant: ProductVariant
    let quantity: Int
}
