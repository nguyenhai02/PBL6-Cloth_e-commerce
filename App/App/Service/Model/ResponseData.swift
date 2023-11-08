//
//  Product.swift
//  App
//
//  Created by Thanh Hien on 21/10/2023.
//

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

struct ProductDetail: Decodable {
    let product: Product
    var productVariants: [ProductVariant]
}

struct Product: Decodable {
    let id: Int
    let name, description: String
    let price, discount: Int
    var image: String?
    let createDate, updateDate: String?
    let category: Categories
}

struct Categories: Decodable {
    let id: Int
    let name, description, createDate, updateDate: String
}
struct ProductVariant: Decodable {
    let id: Int
    var color: String
    var size: String
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
