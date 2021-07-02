//
//  CountieApp.swift
//  Countie
//
//  Created by Niccolo Granieri on 26/06/2021.
//

import SwiftUI

@main
struct CountieApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Elements())
        }
    }
}
