//
//  OrderViewModel.swift
//  App
//
//  Created by Thanh Hien on 18/11/2023.
//

import Foundation
import Moya

class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = []
    
    //    func CreateCOD(amount: Double) {
    //        let token = UserDefaults.standard.string(forKey: Constanst.tokenKey) ?? ""
    //        let tokenPlugin = AccessTokenPlugin{_ in token }
    //        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
    //        let provider = MoyaProvider<MyService>(plugins: [tokenPlugin, plugin])
    //        provider.request(.createCOD(amount: amount)) {result in
    //            switch result {
    //            case .success(_):
    //                print("success")
    //            case let .failure(error):
    //                print("failure: \(error.localizedDescription)")
    //
    //            }
    //        }
    //    }
    func getAllOders() {
        let token = UserDefaults.standard.string(forKey: Constanst.tokenKey) ?? ""
        let tokenPlugin = AccessTokenPlugin { _ in token }
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let provider = MoyaProvider<MyService>(plugins: [tokenPlugin, plugin])
        
        provider.request(.getAllOders) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let orderResponses = try filteredResponse.map([OrderResponse].self)
                    self.orders = orderResponses.map { $0.order}
                    print(self.orders)
                    print("self.orders updated successfully")
                } catch {
                    print("error: \(error.localizedDescription)")
                }
            case let .failure(error):
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
