//
//  ContentView.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import SwiftUI
import RealityKit
import ARKit
import LocationBasedAR

struct ContentView: View
{
    @EnvironmentObject var arSessionManager: ARSessionManager
    @EnvironmentObject var locationManager: LBSManager
    
    var body: some View
    {
        ZStack(alignment: .bottom) {
            ARViewContainer()
            ARControls()
        }
        .actionSheet(item: $arSessionManager.selectedAnchor) { locationAnchor in
            ActionSheet(
                title: Text(locationAnchor.title),
                message: Text(locationAnchor.stringDescription),
                buttons: [
                    .destructive(Text("Remove"), action: {
                        self.arSessionManager.delete(anchorData: locationAnchor)
                    }),
                    .cancel()
                ]
            )
        }
        .onAppear(perform: {
            
            // imitate loading
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.arSessionManager.loadCachedAnchors()
            } 
            
            locationManager.start()
            
            locationManager.onLocationChanged = arSessionManager.receive(location:)
            arSessionManager.configure(locationManager)
        })
        .onDisappear(perform: {
            locationManager.stop()
        })
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

struct ARViewContainer: UIViewRepresentable
{
    @EnvironmentObject var vm: ARSessionManager
    
    func makeUIView(context: Context) -> FocusedARView {
        let arView = vm.arView
        
        self.vm.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self) { event in
            self.updateScene(for: arView)
        }
        
        return arView
    }
    
    func updateUIView(_ uiView: FocusedARView, context: Context) {
        
    }
    
    private func updateScene(for arView: FocusedARView) {
        
        self.vm.updateAnnotations()
    }
    
    typealias UIViewType = FocusedARView
    
}
