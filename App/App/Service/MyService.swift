//
//  MyService.swift
//  App
//
//  Created by Thanh Hien on 12/10/2023.
//

import Foundation
import Moya

enum MyService {
    case register(name: String, email: String, password: String, address: String, phone: String)
    case login(email: String, password: String)
    case showCategories
}

extension MyService: TargetType, AccessTokenAuthorizable {
    var baseURL: URL { URL(string: "http://localhost:8080")! }
    var path: String {
        switch self {
        case .register(_,_,_,_,_):
            return "/user/register"
        case .login(_,_):
            return "/user/login"
        case .showCategories:
            return "/categories/all"
        }
    }
    var method: Moya.Method {
        switch self {
        case .showCategories:
            return .get
        case .register, .login:
            return .post
        }
    }
    var task: Task {
        switch self {
        case .showCategories:
            return .requestPlain
        case .register(name: let name, email: let email, password: let password, address: let address, phone: let phone):
            return .requestParameters(parameters: ["name": name, "email": email, "password": password, "address": address, "phone": phone], encoding: JSONEncoding.default)
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var authorizationType: AuthorizationType? {
        switch self{
        case .showCategories:
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
