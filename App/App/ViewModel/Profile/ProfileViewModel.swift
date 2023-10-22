//
//  ProfileViewModel.swift
//  App
//
//  Created by Thanh Hien on 15/10/2023.
//

import Foundation
import Moya

class ProfileViewModel: ObservableObject {
    @Published var profile: Profile? = nil
    @Published var isLogIned = false
    let array: [ItemSetting] = [ItemSetting(id: 1, image: "tote", tiltle: "My Orders", subtiltle: nil), ItemSetting(id: 2, image: "address2", tiltle: "Delivery Address", subtiltle: nil), ItemSetting(id: 3, image: "payment", tiltle: "Payment Methods", subtiltle: nil), ItemSetting(id: 4, image: "notifications", tiltle: "Notifications", subtiltle: nil)]
    
    init(){
        showProfile()
    }
    
    func logOut() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Constanst.tokenKey)
        defaults.synchronize()
    }
    
    func showProfile() {
        let token = UserDefaults.standard.string(forKey: Constanst.tokenKey) ?? ""
        let tokenPlugin = AccessTokenPlugin{_ in token }
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let provider = MoyaProvider<MyService>(plugins: [tokenPlugin, plugin])
        provider.request(.showProfile) { [weak self] result in
            switch result {
            case let .success(moyaResponse):
                do{
                    let filteredReponse = try moyaResponse.filterSuccessfulStatusCodes()
                    self?.profile = try filteredReponse.map(Profile.self)
                } catch(let err) {
                    print("profile error \(err.localizedDescription)")
                }
            case let .failure(error):
                print(error)
                print("k co profile")
            }
        }
    }
}

struct ItemSetting {
    let id: Int
    let image: String
    let tiltle: String
    let subtiltle: String?
}
