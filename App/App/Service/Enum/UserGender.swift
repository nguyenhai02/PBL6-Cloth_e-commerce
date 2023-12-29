//
//  UserGender.swift
//  App
//
//  Created by Thanh Hien on 27/10/2023.
//

import Foundation


enum Gender: String, CaseIterable, Decodable {
    case MALE = "Nam"
    case FEMALE = "Nữ"
    case UNSPECIFIED = " "
}
