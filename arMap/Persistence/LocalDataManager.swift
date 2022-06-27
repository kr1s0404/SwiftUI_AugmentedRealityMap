//
//  LocalDataManager.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import Foundation
import CoreLocation
import LocationBasedAR
import Firebase


class LocalDataManager: ObservableObject
{
    let defaultLocations = [Placemark]()
    
    @Published var locations = [Placemark]()
    
    static var shared = LocalDataManager()
    
    private init() {
        print(UserDefaultsConfig.description)
        fetch()
    }
    
    func fetch() {
        let db = Firestore.firestore()
        
        db.collection("locations").getDocuments { (snapshot, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            if let snapshot = snapshot {
                DispatchQueue.main.async {
                    self.locations = snapshot.documents.map { d in
                        
                        let point = d["coordinate"] as! GeoPoint
                        
                        return Placemark(location: CLLocation(latitude: point.latitude , longitude: point.longitude),
                                         placeName: d["placeName"] as? String ?? "")
                    }
                    print(self.locations)
                }
            }
        }
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
