//
//  PerpustakaanApp.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 07/05/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct PerpustakaanApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            FirstPage()
        }
    }
}

class AppDelegate: NSObject,UIApplicationDelegate{
     
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
         
        FirebaseApp.configure()
        return true
    }
    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    
}

