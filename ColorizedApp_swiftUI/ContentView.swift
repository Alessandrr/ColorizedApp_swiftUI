//
//  ContentView.swift
//  ColorizedApp_swiftUI
//
//  Created by Александр Мамлыго on /147/2566 BE.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var focusedField: Field?
    
    @State private var alertPresented = false
    
    @State private var redSliderValue = Double.random(in: 0...255).rounded()
    @State private var greenSliderValue = Double.random(in: 0...255).rounded()
    @State private var blueSliderValue = Double.random(in: 0...255).rounded()
    
    var body: some View {
        ZStack {
            Color(.clear)
                .ignoresSafeArea()
                .onTapGesture {
                    focusedField = nil
                }
            
            VStack(spacing: 30) {
                ColorView(red: redSliderValue, green: greenSliderValue, blue: blueSliderValue)
                
                VStack {
                    ColorSliderView(
                        value: $redSliderValue,
                        color: .red
                    )
                    .focused($focusedField, equals: .red)
                    
                    ColorSliderView(
                        value: $greenSliderValue,
                        color: .green
                    )
                    .focused($focusedField, equals: .green)
                    
                    ColorSliderView(
                        value: $blueSliderValue,
                        color: .blue
                    )
                    .focused($focusedField, equals: .blue)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button(action: nextField) {
                            Image(systemName: "arrow.down")
                        }
                        Button(action: previousField) {
                            Image(systemName: "arrow.up")
                        }
                        Spacer()
                        Button("Done") {
                            focusedField = nil
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

extension ContentView {
    private enum Field {
        case red
        case green
        case blue
    }
    
    private func nextField() {
        switch focusedField {
        case .none:
            focusedField = nil
        case .red:
            focusedField = .green
        case .green:
            focusedField = .blue
        case .blue:
            focusedField = .red
        }
    }
    
    private func previousField() {
        switch focusedField {
        case .none:
            focusedField = nil
        case .red:
            focusedField = .blue
        case .green:
            focusedField = .red
        case .blue:
            focusedField = .green
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
