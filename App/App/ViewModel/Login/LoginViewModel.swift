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
    @Published var isLoggIned: Bool = false
    
//    init() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [weak self] in
//            self?.checkLogin()
//        })
//    }
//    
//    func checkLogin(){
//        let token = UserDefaults.standard.string(forKey: Constanst.tokenKey) ?? ""
//        isLoggIned = !token.isEmpty
//    }
    
    func login() {
        guard invalid() else {
            return
        }
        let plugin: PluginType =  NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let provider = MoyaProvider<MyService>(plugins: [plugin])
        provider.request(.login(email: email, password: password)) { result in
            switch result  {
            case let .success(moyaResponse):
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let token = try filteredResponse.map(TokenResponse.self) // user is of type User
                    print("data: \(token.token)")
                    UserDefaults.standard.set(token.token, forKey: Constanst.tokenKey)
                }
                catch {}
                let statusCode = moyaResponse.statusCode
                if statusCode == 200 {
                    self.isLoggIned = true
                } else {
                    self.errorMessage = "Invalid email or password."
                }
            case let .failure(error):
                if let error = error as? MoyaError, let response = error.response {
                    do {
                        // Handle custom error response here
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
    
    private func invalid() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill all fileds"
            return false
        }
        guard email.contains("@") && email.contains(".com")  else {
            errorMessage = " Please enter valid email "
            return false
        }
        return true
    }
}
