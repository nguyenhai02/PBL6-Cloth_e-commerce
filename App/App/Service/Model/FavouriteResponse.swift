//
//  Favourite.swift
//  App
//
//  Created by Thanh Hien on 10/11/2023.
//

import Foundation

struct Favourite: Decodable, Hashable {
    let id: Int
    let name: String
    let description: String
    let price: Int
    let discount: Int
    let image: String?
    let createDate: String
    let updateDate: String
    let category: Categories
}
