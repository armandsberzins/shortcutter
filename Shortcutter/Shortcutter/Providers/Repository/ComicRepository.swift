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
    case nextTen(Int)
    case custom(Int)
}

protocol ComicRepositoryProtocol {
    func get(_ comics: GetComicsType) -> Future<Comic, ApiError>
   // func getNextTenComics(from staring: Int) -> Future<Comics, ApiError>
}

class ComicRepository: ComicRepositoryProtocol {
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    internal func get(_ comic: GetComicsType) -> Future<Comic, ApiError> {
        Future { promise in
            let successHandler: (Comic) throws -> Void = { comic in
                promise(.success(comic))
            }
            
            let errorHandler: (ApiError) -> Void = { networkManagerError in
                print(networkManagerError.description)
                promise(.failure(networkManagerError))
            }
            
            self.networkManager.get(urlString: self.url(for: comic),
                                    successHandler: successHandler,
                                    errorHandler: errorHandler)
        }

    }   
}
