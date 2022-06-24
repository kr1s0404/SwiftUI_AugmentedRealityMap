//
//  SettingsToggleButton.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import SwiftUI

struct SettingsToggleButton: View {
    
    let setting: Setting
    @Binding var isOn: Bool
    
    var body: some View {
        Button(action: {
            self.isOn.toggle()
            print("\(#file) -- \(setting): \(self.isOn)")
        }) {
            VStack {
                Image(systemName: setting.systemIconName)
                    .font(.title)
                    .foregroundColor(self.isOn ? Color(.systemGreen) : Color(.secondaryLabel))
                    .buttonStyle(PlainButtonStyle())
                
                Text(setting.label)
                    .font(.system(size: 17, weight: .medium, design: .default))
                    .foregroundColor(self.isOn ? .label : Color(.secondaryLabel))
                    .padding(.top, 5)
            }
        }
        .frame(width: 100, height: 100)
        .background(Color(.secondarySystemFill))
        .cornerRadius(20.0)
    }
}
