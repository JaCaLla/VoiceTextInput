//
//  ContentView.swift
//  AccessibleTextInput
//
//  Created by Javier Calatrava on 11/12/24.
//

import SwiftUI
import Speech

struct VoiceRecorderView: View {
   @StateObject private var localeManager = appSingletons.localeManager
    @State var name: String = ""
    @State var surename: String = ""
    @State var age: String = ""
    @State var email: String = ""
    var body: some View {
        Form {
            Section {
                Picker("Select language", selection: $localeManager.localeIdentifier) {
                    ForEach(localeManager.locales, id: \.self) { Text($0).tag($0) }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: localeManager.localeIdentifier) {
                }
            }

            Section {
                TextFieldView(textInputValue: $name,
                              placeholder: "Name:",
                              invalidFormatMessage: "Text must be greater than 6 characters!") { textInputValue in
                    textInputValue.count > 6
                }
                
                TextFieldView(textInputValue: $surename,
                              placeholder: "Surename:",
                              invalidFormatMessage: "Text must be greater than 6 characters!") { textInputValue in
                    textInputValue.count > 6
                }
                TextFieldView(textInputValue: $age,
                              placeholder: "Age:",
                              invalidFormatMessage: "Age must be between 18 and 65") { textInputValue in
                    if let number = Int(textInputValue) {
                        return number >= 18 && number <= 65
                    }
                    return false
                }
            }
            
            Section {
                TextFieldView(textInputValue: $email,
                              placeholder: "Email:",
                              invalidFormatMessage: "Must be a valid email address") { textInputValue in
                    let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
                    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
                    return emailPredicate.evaluate(with: textInputValue)
                }
            }   
        }
        .padding()
    }
}

#Preview {
    VoiceRecorderView()
}
