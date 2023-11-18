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
    var body: some Scene {
        let dataStore = DataStore()
        WindowGroup {
            SplashView()
                .environmentObject(dataStore)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
//    @State var path = NavigationPath()
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        var schemes = [String]()
        if let bundleURLTypes = Bundle.main.infoDictionary?["CFBundleURLTypes"] as? [NSDictionary] {
            for bundleURLType in bundleURLTypes {
                if let scheme = bundleURLType["CFBundleURLSchemes"] as? [String] {
                    schemes += scheme
                }
            }
        }

        schemes = schemes.map { $0.lowercased() }

        guard schemes.contains((url.scheme?.lowercased())!) else {
            print("Unknown scheme")
            return false
        }

        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false),
              let host = components.host,
              let queryItems = components.queryItems else {
            return false
        }

        if host == "paymentResult" {
            if let responseCode = queryItems.first(where: { $0.name == "vnp_ResponseCode" })?.value {
                if responseCode == "00" {
                    // Handle successful payment
                    // Example: Show a notification or navigate to a specific screen
//                    path.append("MyOrdersView")
                } else {
                    // Handle unsuccessful payment
                }
            }
        }

        return true
    }

}

