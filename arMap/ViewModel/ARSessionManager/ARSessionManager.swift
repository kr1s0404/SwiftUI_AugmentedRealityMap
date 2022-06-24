//
//  ARSessionManager.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import SwiftUI
import ARKit
import RealityKit
import Combine
import LocationBasedAR


class ARSessionManager: NSObject, ObservableObject
{
    @Published var arView: FocusedARView = FocusedARView(frame: .zero)
    @Published var selectedAnchor: LocationAnchorData? = nil
    
    var sceneObserver: Cancellable?
    
    var annotations: [UUID: AnnotationEntity] = [:]
    
    var addCallback: (([LBAnchor]) -> Void)?
    var removeCallback: (([LBAnchor]) -> Void)?
    
    override init() {
        
        showAnnotations = UserDefaultsConfig.isAnnotationsPreferred
        distanceFilterValue = UserDefaultsConfig.distanceFilterValue
        
        super.init()
        
        self.arView.session.delegate = self
        self.arView.delegate = self
        self.arView.locationUpdateFilter = 0.5
        self.startSession()
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    private var defaultConfig: ARWorldTrackingConfiguration {
        return LBARView.defaultConfiguration()
    }
    
    @Published var showAnnotations: Bool {
        willSet(newValue) {
            UserDefaultsConfig.isAnnotationsPreferred = newValue
            self.resetAnnotations()
            self.arView.resetDistantAnchors().forEach { anchorData in
                guard let anchor = anchorData.anchor,
                      let name = anchor.name, name != "LBAnchor" else { return }
                if newValue {
                    anchorData.anchorEntity?.isEnabled = false
                    if let projection = self.arView.project(anchor.transform.translation) {
                        self.createAnnotation(projection: projection, anchor: anchor)
                    }
                }
                else {
                    if let anchorEntity = anchorData.anchorEntity {
                        anchorEntity.isEnabled = true
                    } else {
                        self.createAnchorEntity(name: name, anchor: anchor)
                    }
                }
            }
        }
    }
    
    @Published var distanceFilterValue: Double {
        didSet(newValue) {
            UserDefaultsConfig.distanceFilterValue = newValue
            self.arView.displayRangeFilter = newValue
        }
    }
    
    private func run(_ configuration: ARWorldTrackingConfiguration, options: ARSession.RunOptions = []) {
        self.arView.session.run(configuration, options: options)
    }
    
    public func startSession() {
        self.run(defaultConfig)
    }
    
    public func stopSession() {
        self.arView.session.pause()
    }
    
    private func resetAnnotations() {
        for (id, anno) in annotations {
            anno.view?.isHidden = true
            anno.view?.removeFromSuperview()
            self.arView.scene.removeAnchor(anno)
        }
        annotations.removeAll()
    }
    
    public func resetSession() {
        
        if !self.annotations.isEmpty { self.resetAnnotations() }
        
        self.arView.removeAll()
        
        LocalDataManager.shared.clearCache()
        
        if let config = arView.session.configuration as? ARWorldTrackingConfiguration {
            self.run(config, options: [.removeExistingAnchors, .resetTracking])
        } else {
            self.run(defaultConfig, options: [.removeExistingAnchors, .resetTracking])
        }
    }
    
    func configure(_ locationProvider: LocationDataProvider) {
        self.arView.locationProvider = locationProvider
        self.arView.startLocationUpdateTimer()
    }
    
    func receive(location update: CLLocation?) {
        if let newLocation = update {
            self.arView.updateLocation(newLocation)
        }
    }
    
    public func updateAnnotations() {
        for (id, anno) in annotations {
            guard id == anno.anchorIdentifier else { return }
            // Gets the 2D screen point of the 3D world point.
            let translation = anno.transformMatrix(relativeTo: nil).translation
            guard let projectedPoint = self.arView.project(translation) else { return }
            
            // Calculates whether the note can be currently visible by the camera.
            let cameraForward = arView.cameraTransform.matrix.columns.2.xyz
            let cameraToWorldPointDirection = normalize(translation - self.arView.cameraTransform.translation)
            let dotProduct = dot(cameraForward, cameraToWorldPointDirection)
            let isVisible = dotProduct < 0

            // Updates the screen position of the note based on its visibility
            anno.projection = Projection(projectedPoint: projectedPoint, isVisible: isVisible)
            anno.updateScreenPosition()
        }
    }
}
