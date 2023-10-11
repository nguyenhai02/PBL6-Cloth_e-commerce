//
//  RegisterViewModel.swift
//  App
//
//  Created by Thanh Hien on 11/10/2023.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var password = ""
    
    func Register() {
        
    }
}
