//
//  AppSingletons.swift
//  LocationSampleApp
//
//  Created by Javier Calatrava on 1/12/24.
//

import Foundation

@MainActor
struct AppSingletons {
    var localeManager: LocaleManager
    
    init(localeManager: LocaleManager = LocaleManager.shared) {
        self.localeManager = localeManager
    }
}

@MainActor var appSingletons = AppSingletons()
