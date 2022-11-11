//
//  OROApp.swift
//  Shared
//
//  Created by mac on 2022/10/25.
//

import SwiftUI
import Firebase

@main
struct OROApp: App {
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
