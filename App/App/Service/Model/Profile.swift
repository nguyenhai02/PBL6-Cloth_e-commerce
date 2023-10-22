//
//  Profile.swift
//  App
//
//  Created by Thanh Hien on 16/10/2023.
//

import Foundation

struct Profile: Decodable {
    var id: Int
    var name: String
    var email: String
    var address: String
    var phone: String
    var role: String
    var enabled: Bool
    var username: String
    var authorities: [Authorities] = []
    var accountNonExpired: Bool = false
    var accountNonLocked: Bool = false
    var credentialsNonExpired: Bool = false
}

struct Authorities: Decodable{
    var authority: String
}
