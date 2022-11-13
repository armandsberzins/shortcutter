//
//  ContentView.swift
//  Shortcutter
//
//  Created by Armands Berzins on 10/11/2022.
//

import SwiftUI

struct RootView: View {
    @StateObject private var tabController = TabController()
    
    var body: some View {
        TabView(selection: $tabController.activeTab) {
            HomeView()
                .tag(Tab.home)
                .tabItem { Label("", systemImage: "photo") }
            HomeView()
                .tag(Tab.offline)
                .tabItem { Label("", systemImage: "archivebox.fill")}
        }
    }
}
