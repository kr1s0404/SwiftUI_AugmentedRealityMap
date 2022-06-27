//
//  Notification.swift
//  ARCLDemo
//
//  Created by Miron Rogovets on 02.06.2021.
//

import Foundation


protocol NotificationMessage
{
    var title: String { get }
    var message: String { get }
}

struct NotificationWrapper: Identifiable
{
    let notification: NotificationMessage
    
    var id: String {
        notification.title + notification.message
    }
}


enum Notification {
    
    enum Raycasting: NotificationMessage {
        case planeFound
        case objectFound
        case failed
        
        var message: String {
            switch self {
            case .failed: return "Failed: no surface detected."
            case .objectFound: return "Virtual object tapped."
            case .planeFound: return "Plane surface detected."
            }
        }
        
        var title: String {
            "Raycasting"
        }
    }
}
