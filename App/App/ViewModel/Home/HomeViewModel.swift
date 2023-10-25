//
//  HomeModel.swift
//  App
//
//  Created by Thanh Hien on 13/10/2023.
//

import Foundation
import Moya

class HomeViewModel: ObservableObject {
    @Published var categories: [Categories] = []
    @Published var products: [Product] = []
    @Published var categoryProduct: [Product] = []
    @Published var categoryId = 0
    @Published var image: UIImage?
    var product: Product = Product(id: 0, name: "", description: "", price: 0, discount: 0, createDate: "", updateDate: "", category: Categories(id: 0, name: "", description: "", createDate: "", updateDate: ""))
    
    
    init() {
        showCategories()
        showProduct()
    }
    
    func loadImage(from urlString: String, oncompleted: @escaping () -> Void) {
        if let url = URL(string: urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    print("urlString")
                    print(urlString)
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                        oncompleted: do {
                            self.image = image
                            }
                        }
                    } else {
                        // Xử lý trường hợp không thể tạo hình ảnh từ dữ liệu
                    }
                } else {
                    // Xử lý trường hợp không thể tải dữ liệu từ URL
                }
            }
        }
    }
    func showProduct() {
        let provider = MoyaProvider<MyService>()
        let sort = "price,asc"
        provider.request(.showProduct(page: 0, size: 10, sort: sort)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let responseData = try filteredResponse.map(ResponseData.self)
                    print("responseData.content")
                    self.products = responseData.content
                    //                    print(self.product)
                    print(responseData.content) // in ra dữ liệu đã được map từ JSON
                } catch {
                    print("Error in processing product data: \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func showCategories() {
        let provider = MoyaProvider<MyService>()
        provider.request(.showCategories) { result in
            switch result {
            case let .success(moyaResponse):
                do{
                    let filteredReponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let categories = try filteredReponse.map([Categories].self)
                    self.categories = categories
                    //                    print(categories)
                } catch {}
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func showCategoryProduct(categoryId: Int) {
        let sort = "price,asc"
        let provider = MoyaProvider<MyService>()
        provider.request(.showProduct(page: 0, size: 10, sort: sort)) { result in
            switch result {
            case let .success(moyaResponse):
                print("producthiproducthi2")
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let responseData = try filteredResponse.map(ResponseData.self)
                    print("responseData.content")
                    self.categoryProduct = responseData.content.filter { product in
                        return product.category.id  == categoryId
                    }
                    print(self.categoryProduct)
                    print("self.categoryProduct")
                    //                    print(responseData.content) // in ra dữ liệu đã được map từ JSON
                } catch {
                    print("Error in processing product data: \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

