//
//  HomeViewModel.swift
//  Shortcutter
//
//  Created by Armands Berzins on 10/11/2022.
//

import Combine
import Foundation

extension HomeView {
    @MainActor
    class HomeViewModel: ObservableObject {
        //MARK: - Dependencies
        let comicRepo: ComicRepositoryProtocol
        
        //MARK: - Outlets
        @Published var comics: ComicsViewProperies?
        @Published var showAlert: Bool = false
        @Published var error: ApiError? = nil
        
        //MARK: - Constant
        let kDefaultIssueAmountForLaod = 10
        
        //MARK: - Global objects
        private var cancelable: AnyCancellable?
        private static let comicProcessingQueue = DispatchQueue(label: "ComicProcessingQueue")
        private var currentShownNewestIssue: Int?
        
        //MARK: - Init
        init(comicRepo: ComicRepositoryProtocol = ComicRepository()) {
            self.comicRepo = comicRepo
            getComics()
        }
        
        //MARK: - Get new data
        func getNext(_ amount: Int? = nil) {
            let next = amount ?? kDefaultIssueAmountForLaod
            let start = currentShownNewestIssue ?? 1
            let end = start + next
            getComics(from: start, to: end)
        }
        
        private func getComics(from starting: Int = 1, to ending: Int = 10) {
            cancelable = self.comicRepo.get(.custom(starting))
                .subscribe(on: Self.comicProcessingQueue)
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { completion in
                        self.handle(completion)
                    },
                    receiveValue: { comic in
                        self.add(comic)
                        self.requesNewIfNeeded(comic, ending)
                    }
                )
        }
        
        //MARK: - Handle received data
        
        private func add(_ comic: Comic) {
            let cellModel = ComicCellPorperties(title: comic.title,
                                                issue: comic.num,
                                                imageUrl: comic.img)
            
            if self.comics == nil {
                self.comics = ComicsViewProperies(arrayLiteral: cellModel)
            } else {
                self.comics?.append(cellModel)
            }
        }
        
        private func requesNewIfNeeded(_ comic: Comic, _ ending: Int) {
            if let num = comic.num {
                let newStart = num + 1
                self.currentShownNewestIssue = newStart
                if num < ending {
                    self.getComics(from: newStart, to: ending)
                }
            }
        }
        
        private func handle(_ completion: Subscribers.Completion<ApiError>) {
            switch completion {
            case .failure(let apiError):
                self.error = apiError
            case .finished:
                self.error = nil
            }
            
            self.showAlert = self.error != nil
        }
        
        //MARK: - Deinit
        deinit {
            cancelable?.cancel()
        }
    }
}
