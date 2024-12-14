//
//  AccessibleTextFieldModifier.swift
//  AccessibleTextInput
//
//  Created by Javier Calatrava on 12/12/24.
//

import SwiftUI

extension View {
    func accessibleTextField(text: Binding<String>, isPressed: Binding<Bool>) -> some View {
        self.modifier(AccessibleTextField(text: text, isPressed: isPressed))
    }
}

struct AccessibleTextField: ViewModifier {
    @StateObject private var viewModel = VoiceRecorderViewModel()
    
    @Binding var text: String
    @Binding var isPressed: Bool
    private let lock = NSLock()
    func body(content: Content) -> some View {
        content
            .onChange(of: viewModel.transcribedText) {
                guard viewModel.transcribedText != "" else { return }
                self.text = viewModel.transcribedText
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        lock.withLock {
                            if !isPressed {
                                isPressed = true
                                viewModel.startRecording(locale: appSingletons.localeManager.getCurrentLocale())
                            }
                        }
                        
                    }
                    .onEnded { _ in
                        
                        if isPressed {
                            lock.withLock {
                                isPressed = false
                                viewModel.stopRecording()
                            }
                        }
                    }
            )
    }
}
