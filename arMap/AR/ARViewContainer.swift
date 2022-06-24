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
