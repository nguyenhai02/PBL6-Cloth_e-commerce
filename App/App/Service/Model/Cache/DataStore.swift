//
//  DataStore.swift
//  App
//
//  Created by Vo Duc Phong on 13/11/2023.
//

import Foundation

class DataStore: ObservableObject {
    @Published var selectedProduct: ProductDetail?
    @Published var imageURL: String?
}
