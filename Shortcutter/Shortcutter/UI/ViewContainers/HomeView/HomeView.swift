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
                
                Spacer()
                
                if homeViewModel.error == nil {
                    Button("Load more comics", action: {
                        homeViewModel.getNext()
                    })
                }
            } else {
                ProgressView()
            }
            
            if homeViewModel.error != nil {
                Button("Try again load comics", action: {
                    homeViewModel.getNext()
                })
            }
        }
        .padding()
        .alert(
            isPresented: $homeViewModel.showAlert,
            content: { Alert(title: Text(homeViewModel.error?.description ?? "")) }
        )
    }
}
