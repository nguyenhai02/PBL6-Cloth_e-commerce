//
//  SplashViewModel.swift
//  App
//
//  Created by Thanh Hien on 15/10/2023.
//

import Foundation

class SplashViewModel: ObservableObject {
    @Published var isPaymentSuccess = false
    
    func checkLogin(completed: (Bool) -> Void){
        let token = UserDefaults.standard.string(forKey: Constanst.tokenKey) ?? ""
        completed(!token.isEmpty)
    }
    
}
