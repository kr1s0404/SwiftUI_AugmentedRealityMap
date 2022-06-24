//
//  ARControls.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import SwiftUI

struct ARControls: View
{
    
    @State var isSettingVisible: Bool = false
    
    var body: some View
    {
        VStack
        {
            BottomControlBar(showSettings: $isSettingVisible)
        }
    }
}

struct BottomControlBar: View
{
    
    @EnvironmentObject var arSessionManager: ARSessionManager

    @Binding var showSettings: Bool
    
    var body: some View
    {
        HStack
        {
            
            Spacer()
            
            Spacer()
            
            
            SystemIconButton(systemIconName: "slider.horizontal.3", action: {
                self.showSettings.toggle()
            })
            .buttonStyle(PlainButtonStyle())
            .sheet(isPresented: $showSettings, content: {
                SettingsView(showSettings: $showSettings)
                    .environmentObject(arSessionManager)
            })
        }
        .padding(30)
        .background(Color.black.opacity(0.25))
    }
}


struct ARControls_Previews: PreviewProvider
{
    static var previews: some View
    {
        ARControls()
    }
}
