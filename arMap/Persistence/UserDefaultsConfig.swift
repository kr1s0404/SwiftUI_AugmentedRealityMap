//
//  UserDefaultsConfig.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import Foundation

public struct UserDefaultsConfig
{
    public static let defaults = UserDefaults.standard
    
    @UserDefault("annotations-preferred-setting", defaultValue: false)
    public static var isAnnotationsPreferred: Bool
    
    @UserDefault("distance-filter-setting", defaultValue: 1000.0)
    public static var distanceFilterValue: Double
    
    @UserDefault("ar-tap-setting", defaultValue: false)
    public static var isARTapEnabled: Bool
    
    @OptionalCodableUserDefault("saved-locations", defaultValue: [])
    public static var savedLocations: [LocationData]?
    
    public static var description: String {
        var str = "UserDefaultsConfig:\n"
        str += "distanceFilterValue = \(distanceFilterValue)\n"
        return str
    }
}
