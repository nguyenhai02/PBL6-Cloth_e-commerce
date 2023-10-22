//
//  LoginViewModel.swift
//  App
//
//  Created by Thanh Hien on 11/10/2023.
//

import Foundation
import Moya

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoggedIn = false
    @Published var errorMessage = ""
    @Published var emailError = ""
    @Published var isLoggIned: Bool = false
    
    func login() {
        guard invalid() else {
            return
        }
        let plugin: PluginType =  NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let provider = MoyaProvider<MyService>(plugins: [plugin])
        provider.request(.login(email: email, password: password)) { [weak self] result in
            switch result  {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let token = try filteredResponse.map(TokenResponse.self) // user is of type User
//                    print("data: \(token.token)")
                    UserDefaults.standard.set(token.token, forKey: Constanst.tokenKey)
                    UserDefaults.standard.set(self?.email ?? "", forKey: Constanst.emailKey)
                }
                catch {}
                let statusCode = moyaResponse.statusCode
                if statusCode == 200 {
                    self?.isLoggIned = true
                } else {
                    self?.errorMessage = "Invalid email or password."
                }
            case let .failure(error):
                if let response = error.response {
                    do {
                        let data = try response.map(Data.self) // Parse your custom error response
                        let errorString = String(data: data, encoding: .utf8)
                        print("Error: \(errorString ?? "Unknown Error")")
                    } catch {
                        print("Unable to map error response")
                    }
                } else {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func onValidateEmail(email: String){
        emailError = email.isEmpty || isValidEmail(email: email) ? "" : "Email is not in correct format"
    }
    
    private func invalid() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill all fileds"
            return false
        }
        return true
    }
}
