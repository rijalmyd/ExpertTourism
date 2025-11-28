//
//  ExpertTourismApp.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 11/11/25.
//

import SwiftUI

@main
struct ExpertTourismApp: App {
    
    init() {
        Resolver.shared.injectModules()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
