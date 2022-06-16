//
//  MapSitesAppApp.swift
//  MapSitesApp
//
//  Created by Marshall  on 6/16/22.
//

import SwiftUI

@main
struct MapSitesAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()

    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
