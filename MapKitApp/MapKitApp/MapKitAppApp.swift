//
//  MapKitAppApp.swift
//  MapKitApp
//
//  Created by Atul Parmar on 04/04/25.
//

import SwiftUI

@main
struct MapKitAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
