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
    @StateObject var vm = ARSessionManager()
    @StateObject var vm2 = LBSManager()
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
                .environmentObject(vm)
                .environmentObject(vm2)
        }
    }
}
