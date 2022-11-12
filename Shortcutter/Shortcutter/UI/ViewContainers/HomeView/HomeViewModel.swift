//
//  HomeViewModel.swift
//  Shortcutter
//
//  Created by Armands Berzins on 10/11/2022.
//

import Foundation

extension HomeView {
    @MainActor class HomeViewModel: ObservableObject {
        //MARK: - Dependencies
        let comicRepo: ComicRepositoryProtocol
        
        //MARK: - Outlets
        @Published var title: String?
        
        //MARK: - Init
        init(comicRepo: ComicRepositoryProtocol = ComicRepository()) {
            self.comicRepo = comicRepo
            getData()
        }
        
        private func getData() {
            self.comicRepo.get(comics: .current)
        }
    }
}

/*
 let decoder = JSONDecoder()
 
 if let file = Bundle(for: type(of: self)).url(forResource: "CurrentComicTestData", withExtension: "json") {
     let data = try! Data(contentsOf: file)
     if let comic = try? decoder.decode(Comic.self, from: data) {
         title = comic.title
     }
 } else {
     print("fail")
 }
 */
