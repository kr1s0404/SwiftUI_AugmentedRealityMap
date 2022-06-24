//
//  LocalDataManager.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import Foundation
import CoreLocation
import LocationBasedAR

public struct LocationData: Codable, Equatable {
    let id: String?
    let name: String?
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let accuracy: CLLocationAccuracy
    
}


class LocalDataManager
{
    let defaultLocations = [
        Placemark(
            coordinate: CLLocationCoordinate2D(latitude: 24.1786683, longitude: 120.6469363),
            accuracy: 0, placeName: "行政大樓"
        )
    ]
    
    static var shared = LocalDataManager()
    
    private init() {
        print(UserDefaultsConfig.description)
    }
    
    func clearCache() {
        UserDefaultsConfig.savedLocations = nil
    }
    
    func loadSavedLocations() -> [LocationData] {
        return UserDefaultsConfig.savedLocations ?? []
    }
    
    func save(_ locations: [LocationData]) {
        var cached = loadSavedLocations()
        cached.append(contentsOf: locations.filter({ !cached.contains($0) }))
        UserDefaultsConfig.savedLocations = cached
    }
    
    func save(_ location: LocationData) {
        var cached = loadSavedLocations()
        if !cached.contains(location) {
            print("\(#file) -- appeding new location to storage: \(location)")
            cached.append(location)
            UserDefaultsConfig.savedLocations = cached
        }
    }
    
    func delete(by id: String) {
        var cached = loadSavedLocations()
        if let index = cached.firstIndex(where: { $0.id != nil && $0.id == id }) {
            cached.remove(at: index)
            UserDefaultsConfig.savedLocations = cached
        }
    }
    
    func delete(_ location: LocationData) {
        var cached = loadSavedLocations()
        if let index = cached.firstIndex(of: location) {
            cached.remove(at: index)
            UserDefaultsConfig.savedLocations = cached
        }
    }
}
