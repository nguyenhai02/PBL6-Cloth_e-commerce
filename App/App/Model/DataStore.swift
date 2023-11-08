//
//  DataStore.swift
//  App
//
//  Created by Thanh Hien on 26/10/2023.
//

import Foundation

class DataStore: ObservableObject {
    @Published var selectedProduct: ProductDetail?
    @Published var imageURL: String?
}
