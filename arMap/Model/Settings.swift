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
    case arInput
    
    var label: String {
        get {
            switch self {
            case .annotations: return "Annotation"
            case .arInput: return "AR Input"
            }
        }
    }
    
    var systemIconName: String {
        get {
            switch self {
            case .annotations: return "text.bubble.fill"
            case .arInput: return "hand.tap.fill"
            }
        }
    }
}
