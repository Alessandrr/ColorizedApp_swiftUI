//
//  ContentView.swift
//  ColorizedApp_swiftUI
//
//  Created by Александр Мамлыго on /147/2566 BE.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var focusedField: Color?
    
    @State private var alertPresented = false
    
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var redInputValue = ""
    
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var greenInputValue = ""
    
    @State private var blueSliderValue = Double.random(in: 0...255)
    @State private var blueInputValue = ""
    
    var body: some View {
        VStack(spacing: 30) {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 5)
                .background(Color(
                    red: redSliderValue / 255,
                    green: greenSliderValue / 255,
                    blue: blueSliderValue / 255)
                )
                .cornerRadius(20)
                .frame(height: 150)
            
            ColorSliderView(
                value: $redSliderValue,
                inputValue: $redInputValue,
                focusColor: $focusedField,
                textColor: .red
            )
            ColorSliderView(
                value: $greenSliderValue,
                inputValue: $greenInputValue,
                focusColor: $focusedField,
                textColor: .green
            )
            ColorSliderView(
                value: $blueSliderValue,
                inputValue: $blueInputValue,
                focusColor: $focusedField,
                textColor: .blue
            )
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button(action: { switchColorField(toNext: false) }) {
                    Image(systemName: "arrow.up")
                }
                Button(action: { switchColorField(toNext: true) }) {
                    Image(systemName: "arrow.down")
                }
                Spacer()
                Button("Done", action: submitColor)
                    .alert("Wrong Format", isPresented: $alertPresented, actions: {}) {
                        Text("Enter a number between 0 and 255")
                    }
            }
        }
    }
    
    private func submitColor() {
        withAnimation {
            if let inputValue = isColorValue(blueInputValue), focusedField == .blue {
                blueSliderValue = inputValue
            }
            else if let inputValue = isColorValue(redInputValue), focusedField == .red {
                redSliderValue = inputValue
            }
            else if let inputValue = isColorValue(greenInputValue), focusedField == .green {
                greenSliderValue = inputValue
            } else {
                alertPresented.toggle()
                return
            }
            focusedField =  nil
        }
    }
    
    private func isColorValue(_ input: String) -> Double? {
        guard let inputValue = Double(input) else { return nil }
        guard (0...255.0).contains(inputValue) else { return nil }
        return inputValue
    }
    
    private func switchColorField(toNext: Bool) {
        let colors: [Color] = [.red, .green, .blue]
        let currentColor = colors.firstIndex(of: focusedField ?? .red) ?? 0
        if toNext {
            guard focusedField != .blue else { return }
            focusedField = colors[currentColor + 1]
        } else {
            guard focusedField != .red else { return }
            focusedField = colors[currentColor - 1]
        }
    }
}


struct ColorSliderView: View {
    @Binding var value: Double
    @Binding var inputValue: String
    
    var focusColor: FocusState<Color?>.Binding
    let textColor: Color
    
    var body: some View {
        HStack {
            Text("\(lround(value))").foregroundColor(textColor)
            Slider(value: $value, in: 0...255, step: 1)
            TextField("\(lround(value))", text: $inputValue)
                .keyboardType(.decimalPad)
                .frame(width: 50)
                .textFieldStyle(.roundedBorder)
                .focused(focusColor, equals: textColor)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
