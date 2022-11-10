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
        
        init() {
            getData()
        }
        
        private func getData() {
            let decoder = JSONDecoder()
            
            if let file = Bundle(for: type(of: self)).url(forResource: "CurrentComicTestData", withExtension: "json") {
                let data = try! Data(contentsOf: file)
                if let comic = try? decoder.decode(Comic.self, from: data) {
                    title = comic.title
                }
            } else {
                print("fail")
            }
        }
    }
}
