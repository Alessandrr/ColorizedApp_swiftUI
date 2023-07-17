//
//  TextFieldView.swift
//  ColorizedApp_swiftUI
//
//  Created by Aleksandr Mamlygo on 17.07.23.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    var action: () -> Void
    
    var body: some View {
        TextField("", text: $text)
            .frame(width: 55, alignment: .trailing)
            .textFieldStyle(.roundedBorder)
            .onSubmit() {
                withAnimation {
                    action()
                }
            }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(text: .constant("128"), action: {})
    }
}
