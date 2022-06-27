//
//  LocationData.swift
//  arMap
//
//  Created by Kris on 6/26/22.
//

import Foundation
import CoreLocation

public struct LocationData: Codable, Equatable
{
    let id: String?
    let name: String?
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let accuracy: CLLocationAccuracy
}
