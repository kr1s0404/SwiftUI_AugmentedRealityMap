//
//  ARViewContainer.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import SwiftUI
import RealityKit
import ARKit
import LocationBasedAR

struct ARViewContainer: UIViewRepresentable
{
    @EnvironmentObject var arSessionManager: ARSessionManager
    
    func makeUIView(context: Context) -> FocusedARView {
        let arView = arSessionManager.arView
        
        self.arSessionManager.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self) { event in
            self.updateScene(for: arView)
        }
        
        return arView
    }
    
    func updateUIView(_ uiView: FocusedARView, context: Context) {
        
    }
    
    private func updateScene(for arView: FocusedARView) {
        
        self.arSessionManager.updateAnnotations()
    }
    
    typealias UIViewType = FocusedARView
}
