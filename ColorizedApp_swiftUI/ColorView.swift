//
//  ColorView.swift
//  ColorizedApp_swiftUI
//
//  Created by Aleksandr Mamlygo on 17.07.23.
//

import SwiftUI

struct ColorView: View {
    var red: Double
    var green: Double
    var blue: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(lineWidth: 5)
            .background(Color(
                red: red / 255,
                green: green / 255,
                blue: blue / 255)
            )
            .cornerRadius(20)
            .frame(height: 150)
    }
}

struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorView(red: 200, green: 200, blue: 200)
    }
}
