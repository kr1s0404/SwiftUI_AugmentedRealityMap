//
//  Settings.swift
//  ARCLDemo
//
//  Created by Miron Rogovets on 17.05.2021.
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
