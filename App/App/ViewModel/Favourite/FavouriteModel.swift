//
//  FavouriteModel.swift
//  App
//
//  Created by Thanh Hien on 09/11/2023.
//

import Foundation
import Moya

class FavouriteViewModel: ObservableObject {
    @Published var favouriteItems : [Favourite] = []
    @Published var id: Int = 0
    @Published var idFavourite: Int = 0
    static var instance = FavouriteViewModel()
    
    func addFavouriteProduct() {
        let token = UserDefaults.standard.string(forKey: Constanst.tokenKey) ?? ""
        let tokenPlugin = AccessTokenPlugin{_ in token }
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let provider = MoyaProvider<MyService>(plugins: [tokenPlugin, plugin])
        provider.request(.addFavouriteProduct(id: id)) {result in
            switch result {
            case .success(_):
                self.getFavouriteProduct()
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
                    self.favouriteItems = favouriteItem
                    print("FavouriteItems")
//                    print(self.favouriteItems)
                } catch {
                    self.favouriteItems = []
                }
            case let .failure(error):
                print(error)
                print(" get yêu thích hàng k thành công")
            }
            
        }
    }
    
    func deleteFavouirteItem() {
        let token = UserDefaults.standard.string(forKey: Constanst.tokenKey) ?? ""
        let tokenPlugin = AccessTokenPlugin{_ in token }
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let provider = MoyaProvider<MyService>(plugins: [tokenPlugin, plugin])
        provider.request(.deleteFavouriteProduct(id: idFavourite)) {result in
            switch result {
            case .success(_):
                    self.getFavouriteProduct()
                print("thanh cong")
            case let .failure(error):
                print(error)
                print("k thanh cong")
            }
        }
    }
    
}
