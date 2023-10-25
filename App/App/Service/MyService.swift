//
//  MyService.swift
//  App
//
//  Created by Thanh Hien on 12/10/2023.
//

import Foundation
import Moya

enum MyService {
    case register(name: String, email: String, password: String, gender: String?, image: String?, address: String, phone: String)
    case login(email: String, password: String)
    case showCategories
    case showProfile
    case showProduct(page: Int, size: Int, sort: String)
}

extension MyService: TargetType, AccessTokenAuthorizable {
    var baseURL: URL { URL(string: "http://localhost:8080")! }
    var path: String {
        switch self {
        case .register(_,_,_,_,_, _,_):
            return "/user/register"
        case .login(_,_):
            return "/user/login"
        case .showCategories:
            return "/category/all"
        case .showProfile:
            return "/user/profile"
        case .showProduct:
            return "/product/all"
        }
    }
    var method: Moya.Method {
        switch self {
        case .showCategories, .showProfile, .showProduct:
            return .get
        case .register, .login:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .showCategories, .showProfile:
            return .requestPlain
        case .register(name: let name, email: let email, password: let password, gender: let gender, image: let image, address: let address, phone: let phone):
            return .requestParameters(parameters: ["name": name, "email": email, "password": password, "address": address, "phone": phone], encoding: JSONEncoding.default)
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case .showProduct(page: let page, size: let size, sort: let sort):
            return .requestParameters(parameters: ["page": page, "size": size, "sort": sort], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var authorizationType: AuthorizationType? {
        switch self{
        case .showProfile:
            return .bearer
        default:
            return nil
        }
    }
}
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data { Data(self.utf8) }
}
