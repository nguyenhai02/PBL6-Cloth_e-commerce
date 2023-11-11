//
//  Address.swift
//  App
//
//  Created by Thanh Hien on 09/11/2023.
//

import Foundation

struct AddressAPI: Decodable {
    let name: String
    let code: Int
    let divisionType: String
    let phoneCode: Int
    let codename: String
    let districts: [District]
    
    enum CodingKeys: String, CodingKey {
        case name, code
        case divisionType = "division_type"
        case phoneCode = "phone_code"
        case codename, districts
    }
}

struct District: Decodable {
    let name: String
    let code: Int
    let codename, divisionType: String
    let provinceCode: Int
    let wards: String?
    
    enum CodingKeys: String, CodingKey {
        case name, code, codename
        case divisionType = "division_type"
        case provinceCode = "province_code"
        case wards
    }
}
