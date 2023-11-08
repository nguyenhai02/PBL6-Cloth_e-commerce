//
//  AppApp.swift
//  App
//
//  Created by Thanh Hien on 19/09/2023.
//

import SwiftUI
import Firebase
import FirebaseCore

@main
struct AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        let dataStore = DataStore()
        WindowGroup {
            SplashView()
                .environmentObject(dataStore)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

