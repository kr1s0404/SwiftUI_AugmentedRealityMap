//
//  ARSessionManager+gestures.swift
//  arMap
//
//  Created by Kris on 6/24/22.
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
