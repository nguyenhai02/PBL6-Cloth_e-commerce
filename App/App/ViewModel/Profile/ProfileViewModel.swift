//
//  ProfileViewModel.swift
//  App
//
//  Created by Thanh Hien on 15/10/2023.
//

import Foundation
import Moya
import FirebaseStorage

class ProfileViewModel: ObservableObject {
   
    @Published var profile: Profile?
    @Published var name: String = ""
    @Published var address: String = ""
    @Published var phone: String = ""
    @Published var gender = ""
    @Published var avatar: String = ""
    @Published var isLogIned = false
    @Published var image: UIImage?
    let array: [ItemSetting] = [ItemSetting(id: 1, image: "tote", tiltle: "My Orders", subtiltle: nil), ItemSetting(id: 2, image: "address2", tiltle: "Delivery Address", subtiltle: nil), ItemSetting(id: 3, image: "payment", tiltle: "Payment Methods", subtiltle: nil), ItemSetting(id: 4, image: "notifications", tiltle: "Notifications", subtiltle: nil)]
    
    init(){
        self.showProfile()
    }
    
    func logOut() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Constanst.tokenKey)
        defaults.synchronize()
    }
    
    func loadImageProfile(from urlString: String, completed: @escaping () -> Void) {
        if let url = URL(string: urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    print("urlString")
                    print(urlString)
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.image = image
                            completed()
                        }
                    } else {
                        print("k thể tạo ảnh")
                    }
                } else {
                    print("k the tạo")
                }
            }
        }
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
                    self?.loadImageProfile(from: self?.profile?.avatar ?? "https://i.pinimg.com/736x/c6/e5/65/c6e56503cfdd87da299f72dc416023d4.jpg", completed: { [self] in
                        print("tai anh thanh cong")
                        self?.name = self?.profile?.name ?? ""
                        self?.phone = self?.profile?.phone ?? ""
                        self?.gender = self?.profile?.gender ?? ""
                    })
                } catch(let err) {
                    print("profile error \(err.localizedDescription)")
                }
            case let .failure(error):
                print(error)
                print("k co profile")
            }
        }
    }
    func updateProfile() {
        let token = UserDefaults.standard.string(forKey: Constanst.tokenKey) ?? ""
        let tokenPlugin = AccessTokenPlugin{_ in token }
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let provider = MoyaProvider<MyService>(plugins: [tokenPlugin, plugin])
        provider.request(.updateProfile(name: name, address: address, phone: phone, gender: gender, avatar: avatar)) { [self] result in
            print(name, address, phone, gender, avatar)
            switch result {
            case .success(_):
                    print("update thành công")
            case let .failure(error):
                print(error)
                print(" update k thành công: \(error.localizedDescription)")
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
