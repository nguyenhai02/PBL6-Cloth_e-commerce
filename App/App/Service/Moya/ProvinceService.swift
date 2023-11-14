//
//  Address.swift
//  App
//
//  Created by Thanh Hien on 09/11/2023.
//

import Foundation
import Moya

enum ProvinceService {
    case getProvinces
}

extension ProvinceService: TargetType {
    var baseURL: URL { return URL(string: "https://provinces.open-api.vn")! }
    
    var path: String {
        switch self {
        case .getProvinces:
            return "/api/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProvinces:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getProvinces:
            return .requestParameters(parameters: ["depth": 3], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
