//
//  ColorSliderView.swift
//  ColorizedApp_swiftUI
//
//  Created by Aleksandr Mamlygo on 17.07.23.
//

import SwiftUI


struct ColorSliderView: View {
    
    @Binding var value: Double
    @State private var text = ""
    @State private var showAlert = false
    
    let color: Color
    
    var body: some View {
        HStack {
            Text(value.formatted())
            
            Slider(value: $value, in: 0...255, step: 1)
                .tint(color)
                .onChange(of: value) { newValue in
                    text = newValue.formatted()
                }
            
            TextFieldView(text: $text, action: isColorValue)
                .alert("Wrong Format", isPresented: $showAlert, actions: {}) {
                    Text("Enter a number between 0 and 255")
                }
        }
        .onAppear {
            text = value.formatted()
        }
    }
    
    private func isColorValue() {
        if let inputValue = Double(text), (0...255.0).contains(inputValue) {
            value = inputValue
            return
        }
        showAlert.toggle()
        value = 0
        text = ""
    }
}

struct ColorSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSliderView(value: .constant(10), color: .red)
    }
}
