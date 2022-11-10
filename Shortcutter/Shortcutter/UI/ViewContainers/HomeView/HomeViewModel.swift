//
//  HomeViewModel.swift
//  Shortcutter
//
//  Created by Armands Berzins on 10/11/2022.
//

import Foundation

extension HomeView {
    @MainActor class HomeViewModel: ObservableObject {
        @Published var title: String?
    }
}
