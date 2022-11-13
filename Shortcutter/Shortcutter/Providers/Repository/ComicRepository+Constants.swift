//
//  ComicRepository+Constants.swift
//  Shortcutter
//
//  Created by Armands Berzins on 12/11/2022.
//

import Foundation

extension ComicRepository {
    func url(for type: GetComicsType) -> String {
        switch type {
        case .current:
            return "https://xkcd.com/info.0.json"
        case .nextTen:
            return "https://xkcd.com/614/info.0.json"
        case .custom(let issue):
            return "https://xkcd.com/\(issue)/info.0.json"
        }
    }
}
