//
//  CategoryProductViewModel.swift
//  App
//
//  Created by Thanh Hien on 23/10/2023.
//

import Foundation
import Moya
class CategoryProductViewModel {
    @Published var categories: [Category] = []
    @Published var product: [Product] = []
    @Published var categoryProduct: [Product] = []
    @Published var categoryId = 0
    
    
    
    init() {
        showCategoryProduct(categoryId: categoryId)
    }
    func showCategoryProduct(categoryId: Int) {
        let sort = "price,asc"
        let provider = MoyaProvider<MyService>()
        provider.request(.showProduct) { result in
            switch result {
            case let .success(moyaResponse):
                print("producthiproducthi2")
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let responseData = try filteredResponse.map(ResponseData.self)
                    print("responseData.content")
                    self.product = responseData.content.map {$0.product}
                    self.categoryProduct = self.product.filter { product in
                        return product.category.id  == categoryId
                    }
                    print(self.product)
                    print(responseData.content) // in ra dữ liệu đã được map từ JSON
                } catch {
                    print("Error in processing product data: \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

