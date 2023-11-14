//
//  AccessTokenResponse.swift
//  App
//
//  Created by Vo Duc Phong on 14/11/2023.
//

import Foundation

struct AccessTokenResponse: Codable {
    let scope: String
    let access_token: String
    let app_id: String
    let expires_in: String
    let nonce: String
}
