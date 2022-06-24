//
//  SettingsGrid.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var showSettings: Bool
    
    var body: some View
    {
        NavigationView
        {
            SettingsGrid()
                .navigationBarTitle(Text("Settings"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.showSettings.toggle()
                }) {
                    Text("Done").bold()
                })
        }
    }
}


struct SettingsGrid: View
{
    
    @EnvironmentObject var arSessionManager: ARSessionManager
    
    private var gridItemLayout = [GridItem(.adaptive(minimum: 100, maximum: 100), spacing: 25)]
    
    var body: some View
    {
        ScrollView
        {
            
            VStack(spacing: 25)
            {
                
                Text("App Settings")
                    .font(.title2).bold()
                    .padding(.top, 10)
                
                LazyVGrid(columns: gridItemLayout, spacing: 25) {
                    SettingsToggleButton(setting: .annotations, isOn: $arSessionManager.showAnnotations)
                }
                
                SliderControl(label: "Distance Filter", value: $arSessionManager.distanceFilterValue)
                    .frame(maxWidth: 350)
                
                Separator()
            }
        }
        .padding(.top, 35)
    }
}
