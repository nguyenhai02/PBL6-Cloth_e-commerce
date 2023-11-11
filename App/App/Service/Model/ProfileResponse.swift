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
    var gender: String?
    var avatar: String?
    var address: String?
    var phone: String
    var role: String
    var enabled: Bool
    var accountNonExpired: Bool = true
    var accountNonLocked: Bool = true
    var credentialsNonExpired: Bool = true
    var username: String
    var authorities: [Authorities] = []
}

struct Authorities: Decodable{
    var authority: String
}
