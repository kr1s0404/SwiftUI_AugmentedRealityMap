//
//  arMapApp.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import SwiftUI
import Firebase

@main
struct arMapApp: App
{
    @StateObject var arSessionManager = ARSessionManager()
    @StateObject var locationManager = LBSManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
                .environmentObject(arSessionManager)
                .environmentObject(locationManager)
        }
    }
}
