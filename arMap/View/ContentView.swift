//
//  ContentView.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import SwiftUI

struct ContentView: View
{
    @EnvironmentObject var arSessionManager: ARSessionManager
    @EnvironmentObject var locationManager: LBSManager
    
    var body: some View
    {
        ZStack(alignment: .bottom)
        {
            ARViewContainer()
            ARControls()
        }
        .actionSheet(item: $arSessionManager.selectedAnchor) { locationAnchor in
            ActionSheet(
                title: Text(locationAnchor.title),
                message: Text(locationAnchor.stringDescription),
                buttons: [
                    .destructive(Text("移除"), action: {
                        self.arSessionManager.delete(anchorData: locationAnchor)
                    }),
                    .cancel()
                ]
            )
        }
        .onAppear {
            
            // imitate loading
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.arSessionManager.loadCachedAnchors()
            }
            
            
            
            locationManager.start()
            
            locationManager.onLocationChanged = arSessionManager.receive(location:)
            arSessionManager.configure(locationManager)
        }
        .onDisappear {
            locationManager.stop()
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}


