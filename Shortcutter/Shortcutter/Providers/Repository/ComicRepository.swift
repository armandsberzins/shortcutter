//
//  ComicRepository.swift
//  Shortcutter
//
//  Created by Armands Berzins on 12/11/2022.
//

import Foundation

enum GetComicsType {
    case current
    case nextTen
    case custom(Int)
}

protocol ComicRepositoryProtocol {
    func get(comics: GetComicsType)
}

class ComicRepository: ComicRepositoryProtocol {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    internal func get(comics: GetComicsType) {
        let successHandler: (Comic) throws -> Void = { comic in
            //publish comic
            print(comic)
        }
        
        let errorHandler: (ApiError) -> Void = { networkManagerError in
            //publish errpo
            print(networkManagerError.description)
        }
        
        networkManager.get(urlString: "https://xkcd.com/info.0.json", successHandler: successHandler, errorHandler: errorHandler)
    }
}
