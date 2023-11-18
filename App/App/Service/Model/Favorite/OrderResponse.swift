//
//  OrderResponse.swift
//  App
//
//  Created by Thanh Hien on 18/11/2023.
//

import Foundation

struct OrderResponse: Decodable, Hashable {
    let id: Int
    let orderDate: String
    let totalPrice: Double
    let paymentMethod: String
    let status: String
    let user: Profile
}
