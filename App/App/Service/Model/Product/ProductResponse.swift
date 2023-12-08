//
//  Product.swift
//  App
//
//  Created by Thanh Hien on 21/10/2023.
//

import Foundation

struct ResponseData: Decodable {
    let content: [ProductDetail]
    let pageable: Pageable
    let last: Bool
    let totalPages, totalElements: Int
    let first: Bool
    let size, number: Int
    let sort: Sort
    let numberOfElements: Int
    let empty: Bool
}

struct ProductDetail: Identifiable, Decodable, Hashable {
    var id: String? = UUID().uuidString
    
    let product: Product
    var productVariants: [ProductVariant]
}

struct Product: Decodable, Hashable {
    let id: Int
    let name, description: String
    let price, discount: Int
    var image: String?
    let createDate, updateDate: String?
    let category: Categories
}

struct Categories: Decodable, Hashable {
    let id: Int
    let name, description, createDate, updateDate: String
}
struct ProductVariant: Decodable, Hashable {
    let id: Int
    var color, size: String
    var quantity: Int
}

struct Pageable: Decodable {
    let sort: Sort
    let offset, pageNumber, pageSize: Int
    let paged, unpaged: Bool
}

struct Sort: Decodable {
    let empty, sorted, unsorted: Bool
}
