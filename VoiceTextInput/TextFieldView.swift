//
//  TextFieldView.swift
//  VoiceTextInput
//
//  Created by Javier Calatrava on 14/12/24.
//

import SwiftUI

struct TextFieldView: View {
    
    @State private var isPressed = false
    
    @State private var borderColor = Color.gray
    @StateObject private var localeManager = appSingletons.localeManager

    @Binding var textInputValue: String
    let placeholder: String
    let invalidFormatMessage: String?
    var isValid: (String) -> Bool = { _ in true }
    
    var body: some View {
        VStack(alignment: .leading) {
            if !textInputValue.isEmpty {
                Text(placeholder)
                    .font(.caption)
            }
            TextField(placeholder, text: $textInputValue)
                .accessibleTextField(text: $textInputValue, isPressed: $isPressed)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(borderColor),
                    alignment: .bottom
                )
            .onChange(of: textInputValue) { oldValue, newValue in
                    borderColor = getColor(text: newValue, isPressed: isPressed )
            }
            .onChange(of: isPressed) {
                    borderColor = getColor(text: textInputValue, isPressed: isPressed )
            }
            if !textInputValue.isEmpty,
               !isValid(textInputValue),
                let invalidFormatMessage {
                Text(invalidFormatMessage)
                    .foregroundColor(Color.red)
            }
        }
    }
    
    func getColor(text: String, isPressed: Bool) -> Color {
        guard !isPressed else { return Color.orange }
        guard !text.isEmpty else { return Color.gray }
        return isValid(text) ? Color.green : Color.red
    }
    
}
