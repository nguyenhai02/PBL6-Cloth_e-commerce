//
//  AddressModel.swift
//  App
//
//  Created by Thanh Hien on 11/11/2023.
//

import Foundation

struct Address: Codable, Hashable {
    var name: String
    var phone: String
    var street: String
    var city: String
    var ward: String
    var district: String
}
