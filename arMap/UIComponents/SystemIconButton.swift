//
//  ControlButton.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import SwiftUI

struct SystemIconButton: View {
    
    let systemIconName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: { self.action() }) {
            Image(systemName: systemIconName)
                .font(.title)
                .padding()
                .frame(width: 50, height: 50)
        }
    }
}
