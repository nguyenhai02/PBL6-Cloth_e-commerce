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
    @Published var product: [Product] = []
    
    init() {
        showCategories()
        showProduct()
    }
    func showProduct() {
        let token = UserDefaults.standard.string(forKey: Constanst.tokenKey) ?? ""
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let provider = MoyaProvider<MyService>(plugins: [plugin])
        provider.request(.showProduct) { result in
            switch result {
            case let .success(moyaResponse):
                do{
                    let filteredReponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let product = try filteredReponse.map([Product].self)
                    self.product = product
//                    print(product)
                } catch {}
            case let .failure(error):
                print(error)
            }
        }
    }
    func showCategories() {
        let token = UserDefaults.standard.string(forKey: Constanst.tokenKey) ?? ""
        let tokenPlugin = AccessTokenPlugin{_ in token }
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let provider = MoyaProvider<MyService>(plugins: [tokenPlugin, plugin])
        provider.request(.showCategories) { result in
            switch result {
            case let .success(moyaResponse):
                do{
                    let filteredReponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let categories = try filteredReponse.map([Categories].self)
                    self.categories = categories
                    print("categories ne ban")
                    print(categories)
                } catch {}
            case let .failure(error):
                print(error)
            }
        }
    }
}
