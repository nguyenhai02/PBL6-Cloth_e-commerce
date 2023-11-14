//
//  AppApp.swift
//  App
//
//  Created by Thanh Hien on 19/09/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
struct AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var path = NavigationPath()
    var body: some Scene {
        let dataStore = DataStore()
        WindowGroup {
            NavigationStack(path: $path){
                TransferMoneyView(path: $path)
            }
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

