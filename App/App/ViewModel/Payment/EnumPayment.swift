//
//  EnumPayment.swift
//  App
//
//  Created by Vo Duc Phong on 13/11/2023.
//

import Foundation


enum Intent: String, CaseIterable, Identifiable {
    case authorize = "AUTHORIZE"
    case capture = "CAPTURE"
    var id: Self { self }
}

enum LoadingState<T: Decodable & Equatable>: Equatable {

    case idle
    case loading
    case error(message: String)
    case loaded(_ value: T)
}
