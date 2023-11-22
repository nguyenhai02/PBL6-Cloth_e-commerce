//
//  AppApp.swift
//  App
//
//  Created by Thanh Hien on 19/09/2023.
//

import SwiftUI
import FirebaseCore

@main
struct AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var isDeepLinkSuccess = false
    @ObservedObject var viewModel = SplashViewModel()
    let dataStore = DataStore()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(viewModel)
                .environmentObject(dataStore)
                .onOpenURL(perform: { _ in
                    print("###############->onOpenURL")
                    viewModel.isPaymentSuccess = true
                })
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var onNavigateToSuccessScreen: (() -> Void)? = nil
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return true
    }
    
}
