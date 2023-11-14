//
//  AddressReponse.swift
//  App
//
//  Created by Thanh Hien on 09/11/2023.
//

struct Province: Decodable, Hashable {
    let name: String
    let code: Int
    let codename: String
    let division_type: String
    let phone_code: Int
    let districts: [District]?
}

struct District: Decodable, Hashable {
    let name: String
    let code: Int
    let codename: String
    let division_type: String
    let short_codename: String
    let wards: [Ward]?
}

struct Ward: Decodable, Hashable {
    let name: String
    let code: Int
    let codename: String
    let division_type: String
    let short_codename: String
}

