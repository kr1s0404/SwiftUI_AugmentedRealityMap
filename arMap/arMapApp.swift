//
//  arMapApp.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import SwiftUI

@main
struct arMapApp: App
{
    @StateObject var arSessionManager = ARSessionManager()
    @StateObject var locationManager = LBSManager()
    
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
