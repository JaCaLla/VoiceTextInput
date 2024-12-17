//
//  LocaleManager.swift
//  AccessibleTextInput
//
//  Created by Javier Calatrava on 13/12/24.
//

import Foundation
@MainActor
final class LocaleManager: NSObject, ObservableObject {
    let locales = [
         "es-ES",
         "en-US",
         "fr-FR"
    ]
    
    let defaultLocale = "es-ES"
   // @Published var locale: Locale = Locale(identifier: "es-ES")
    @Published var localeIdentifier = "es-ES"

    
    static var shared: LocaleManager = LocaleManager()
    
    func getCurrentLocale() -> Locale {
        Locale(identifier: localeIdentifier)
    }
}
