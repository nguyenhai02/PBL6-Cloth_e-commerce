//
//  AddressViewModel.swift
//  App
//
//  Created by Thanh Hien on 23/10/2023.
//

import Foundation

class AddressViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var phone: String = ""
    @Published var street: String = ""
    @Published var city: String = ""
    @Published var district: String = ""
}
