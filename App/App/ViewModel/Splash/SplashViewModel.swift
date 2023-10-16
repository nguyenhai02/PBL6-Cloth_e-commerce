//
//  SplashViewModel.swift
//  App
//
//  Created by Thanh Hien on 15/10/2023.
//

import Foundation

class SplashViewModel: ObservableObject {
    @Published var isLoggIned: Bool = false
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [weak self] in
            self?.checkLogin()
        })
    }
    
    func checkLogin(){
        let token = UserDefaults.standard.string(forKey: Constanst.tokenKey) ?? ""
        isLoggIned = !token.isEmpty
    }
    
}
