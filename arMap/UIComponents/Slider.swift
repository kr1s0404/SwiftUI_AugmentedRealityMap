//
//  Slider.swift
//  arMap
//
//  Created by Kris on 6/24/22.
//

import SwiftUI

struct SliderControl: View
{
    var label: String
    var range: ClosedRange<Double> = 100...5000
    var step: Double = 100
    @Binding var value: Double
    
    var body: some View
    {
        VStack
        {
            Text("\(label): \(Int(value))")
            
            Slider(value: $value, in: range, step: step)
                .accentColor(Color(.systemGreen))
        }
        .padding()
    }
}
