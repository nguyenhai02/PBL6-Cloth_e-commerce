//
//  Favourite.swift
//  App
//
//  Created by Thanh Hien on 10/11/2023.
//

import Foundation

struct Favourite: Decodable, Hashable {
    var id: Int
    let product: Product
}
