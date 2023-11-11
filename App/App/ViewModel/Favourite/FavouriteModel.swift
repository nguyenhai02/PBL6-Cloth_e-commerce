//
//  FavouriteModel.swift
//  App
//
//  Created by Thanh Hien on 09/11/2023.
//

import Foundation
import Moya

class FavouriteViewModel: ObservableObject {
    @Published var FavouriteItems : [Favourite] = []
    @Published var id: Int = 0
    @Published var idProduct: Int = 0
    
    init() {
        getFavouriteProduct()
    }
    func addFavouriteProduct() {
        let token = UserDefaults.standard.string(forKey: Constanst.tokenKey) ?? ""
        let tokenPlugin = AccessTokenPlugin{_ in token }
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let provider = MoyaProvider<MyService>(plugins: [tokenPlugin, plugin])
        provider.request(.addFavouriteProduct(id: id)) {result in
            switch result {
            case let .success(moyaResponse):
                    print(" thêm yêu thích hàng  thành công")
            case let .failure(error):
                print(error)
                print(" thêm yêu thích hàng k thành công")
            }
        }
    }
    
    func getFavouriteProduct() {
        let token = UserDefaults.standard.string(forKey: Constanst.tokenKey) ?? ""
        let tokenPlugin = AccessTokenPlugin{_ in token }
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let provider = MoyaProvider<MyService>(plugins: [tokenPlugin, plugin])
        provider.request(.getFavouriteProduct) { result in
            switch result {
            case  let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let favouriteItem = try filteredResponse.map([Favourite].self)
                    self.FavouriteItems = favouriteItem
                    print("FavouriteItems")
                    print(self.FavouriteItems)
                } catch {
                    self.FavouriteItems = []
                }
            case let .failure(error):
                print(error)
                print(" get yêu thích hàng k thành công")
            }
            
        }
    }
    
    func deleteCartItems() {
        let token = UserDefaults.standard.string(forKey: Constanst.tokenKey) ?? ""
        let tokenPlugin = AccessTokenPlugin{_ in token }
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let provider = MoyaProvider<MyService>(plugins: [tokenPlugin, plugin])
        provider.request(.deleteFavouriteProduct(id: idProduct)) {result in
            switch result {
            case .success(_):
                    self.getFavouriteProduct()
                print("Xoas thanhf coong")
            case let .failure(error):
                print(error)
                print("Xoa k thanh cong")
            }
        }
    }
    
}
