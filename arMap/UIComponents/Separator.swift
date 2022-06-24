//
//  Separator.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import SwiftUI


struct Separator: View {
    
    var horizontalPadding: CGFloat = 20
    var verticalPadding: CGFloat = 10
    
    var body: some View {
        Divider()
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
    }
}
