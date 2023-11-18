//
//  PaymentResponse.swift
//  App
//
//  Created by Thanh Hien on 16/11/2023.
//

import Foundation

struct PaymentResponse: Decodable {
    let vnp_BankCode: String
    let vnp_CurrCode: String
    let vnp_OrderType: String
    let vnp_ReturnUrl: String
    let vnp_TmnCode: String
    let vnp_TxnRef: String
    let vnp_OrderInfo: String
    let vnp_Amount: String
    let vnp_IpAddr: String
    let vnp_Locale: String
    let vnp_Command: String
    let vnp_ExpireDate: String
    let vnp_CreateDate: String
    let vnp_Version: String
    let redirect_url: String
}
