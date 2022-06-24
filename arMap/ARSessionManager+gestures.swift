//
//  ARSessionManager+gestures.swift
//  ARCLDemo
//
//  Created by Miron Rogovets on 02.06.2021.
//

import Foundation
import ARKit
import RealityKit
import LocationBasedAR


extension ARSessionManager {
    
    
    internal func annotationTapSetup(_ annotation: AnnotationEntity) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedOnAnnotation(_:)))
        annotation.view?.addGestureRecognizer(tap)
    }
    
    @objc func tappedOnAnnotation(_ sender: UITapGestureRecognizer) {
        guard let annotationView = sender.view as? AnnotationView else { return }
        self.arView.bringSubviewToFront(annotationView)
    }
    
    
}
