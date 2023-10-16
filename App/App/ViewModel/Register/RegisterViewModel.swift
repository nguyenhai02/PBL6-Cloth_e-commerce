//
//  RegisterViewModel.swift
//  App
//
//  Created by Thanh Hien on 11/10/2023.
//

import Foundation
import Moya

class RegisterViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var address = ""
    @Published var phone = ""
    @Published var isRegistered: Bool = false
    @Published var errorMessage = ""
    
    func Register() {
        guard invalid() else {
            return
        }
        let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let provider = MoyaProvider<MyService>(plugins: [plugin])
        provider.request(.register(name: name, email: email, password: password, address: address, phone: phone)) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let moyaStatus = moyaResponse.statusCode
                if moyaStatus == 200 {
                    self.isRegistered = true
                } else {
                    self.errorMessage = "Email already exists."
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^\\d{10}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phone)
    }
    
    private func invalid() -> Bool {
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty, !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty, !address.trimmingCharacters(in: .whitespaces).isEmpty, !phone.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill all fileds"
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = " Please enter valid email "
            return false
        }
        guard isValidPhone(phone: phone) else {
               errorMessage = "Please enter a valid 10-digit phone number"
               return false
           }
        return true
    }
}
