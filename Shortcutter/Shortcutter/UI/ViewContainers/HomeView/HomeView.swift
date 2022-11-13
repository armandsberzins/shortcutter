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
            if let comics = homeViewModel.comics {
                List(comics) { comic in
                    ComicCell(properties: comic)
                }.navigationTitle("Comics")
            } else {
                Text("No Comics :/")
            }
            
            Button("Load more comics", action: {
                homeViewModel.getNext()
            })
        }
        .padding()
    }
}
