//
//  HomeModel.swift
//  App
//
//  Created by Thanh Hien on 13/10/2023.
//

import Foundation
import Moya
import Combine

class HomeViewModel: ObservableObject {
    @Published var categories: [Categories] = []
    @Published var products: [ProductDetail] = []
//    @Published var products: [Product] = []
    @Published var categoryProduct: [ProductDetail] = []
    @Published var categoryProductByName: [ProductDetail] = []
    @Published var productVariants: [ProductVariant] = []
    @Published var categoryId = -1
    @Published var idProductVariant = 0
    @Published var id: Int = 0
    @Published var sort = ""
    var quantity: Int = 0
    var productDetail: ProductDetail? = nil
    let searchPublicsher = PassthroughSubject<String, Never>()
    var searchText: String = ""
    
    
    init() {
        showCategories()
        showProduct()
    }
    
    func getProductDetail() {
        let provider = MoyaProvider<MyService>()
        provider.request(.getItemDetail(id: id)) { result in
            switch result {
            case let .success(moyaResponse):
                do{
                    print(self.id)
                    let filteredReponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let productDetail = try filteredReponse.map(ProductDetail.self)
                    self.productDetail = productDetail
//                    print(self.productDetail)
                } catch { print("product2")}
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func showProduct() {
        let provider = MoyaProvider<MyService>()
//            .showProduct(page: 0, size: 10, sort: sort)
        provider.request(.showProduct(sort: sort)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let responseData = try filteredResponse.map(ResponseData.self)
                    print("responseData.content")
                    self.products = responseData.content
//                    print(responseData.content)
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
    
    func showCategoryProduct() {
        let provider = MoyaProvider<MyService>()
        provider.request(.showProduct(sort: sort)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let responseData = try filteredResponse.map(ResponseData.self)
                    self.categoryProduct = responseData.content.filter{$0.product.category.id == self.categoryId || self.categoryId == -1}
                        .filter{$0.product.name.lowercased().contains(self.searchText.lowercased()) || self.searchText.isEmpty}
                    print(responseData.content)
                    print(self.categoryProduct)
                } catch {
                    print("Error in processing product data: \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func searchByName(text: String) {
        let provider = MoyaProvider<MyService>()
        provider.request(.showProduct(sort: sort)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let responseData = try filteredResponse.map(ResponseData.self)
                    if(text.isEmpty){
                        self.categoryProductByName = responseData.content
                    }else{
                        self.categoryProductByName = responseData.content.filter{$0.product.name.lowercased().contains(text.lowercased())}
                    }
                    print(self.categoryProductByName)
                } catch {
                    print("Error in processing product data: \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

