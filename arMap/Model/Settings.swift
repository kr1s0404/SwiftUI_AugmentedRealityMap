//
//  Settings.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import Foundation


enum Setting
{
    case annotations
    
    var label: String {
        get {
            switch self {
            case .annotations: return "Annotation"
            }
        }
    }
    
    var systemIconName: String {
        get {
            switch self {
            case .annotations: return "text.bubble.fill"
            }
        }
    }
}
