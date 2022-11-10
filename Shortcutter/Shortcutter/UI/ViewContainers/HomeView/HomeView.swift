//
//  HomeView.swift
//  Shortcutter
//
//  Created by Armands Berzins on 10/11/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(homeViewModel.title ?? "")
        }
        .padding()
    }
}
