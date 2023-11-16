//
//  AddressReponse.swift
//  App
//
//  Created by Thanh Hien on 09/11/2023.
//

struct Province: Decodable, Hashable {
    var name: String
    var code: Int
    var codename: String
    var division_type: String
    var phone_code: Int
    var districts: [District]?
}


struct District: Decodable, Hashable {
    var name: String
    var code: Int
    var codename: String
    var division_type: String
    var short_codename: String
    var wards: [Ward]?
}

struct Ward: Decodable, Hashable {
    var name: String
    var code: Int
    var codename: String
    var division_type: String
    var short_codename: String
}

