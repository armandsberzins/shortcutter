//
//  ComicRepository.swift
//  Shortcutter
//
//  Created by Armands Berzins on 12/11/2022.
//

import Combine
import Foundation

enum GetComicsType {
    case current
    case custom(Int)
}

protocol ComicRepositoryProtocol {
    func get(_ comics: GetComicsType) -> Future<Comic, ApiError>
}

class ComicRepository: ComicRepositoryProtocol {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    internal func get(_ comicsType: GetComicsType) -> Future<Comic, ApiError> {
        Future { promise in
            let issueNumber = self.customIssueNumber(from: comicsType)
            
            if let localComic = ComicStorage.loadComic(for: issueNumber) {
                promise(.success(localComic))
                self.updateInBackground(comicsType)
            } else {
                let successHandler: (Comic) throws -> Void = { comic in
                    ComicStorage.save(comic)
                    promise(.success(comic))
                }
                
                let errorHandler: (ApiError) -> Void = { networkManagerError in
                    print(networkManagerError.description)
                    promise(.failure(networkManagerError))
                }
                
                self.networkManager.get(urlString: self.url(for: comicsType),
                                        successHandler: successHandler,
                                        errorHandler: errorHandler)
            }
        }
    }
    
    private func updateInBackground(_ comicsType: GetComicsType) {
        self.networkManager.get(urlString: self.url(for: comicsType),
                                successHandler: { comic in ComicStorage.save(comic)},
                                errorHandler: { _ in })
    }
}
