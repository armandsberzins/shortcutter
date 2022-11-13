//
//  ComicCellProperties.swift
//  Shortcutter
//
//  Created by Armands Berzins on 13/11/2022.
//

import Kingfisher
import Foundation
import SwiftUI

typealias ComicsViewProperies = [ComicCellPorperties]

protocol ComicsCellViewProperiesProtocol {
    var title: String? { get }
    var issue: Int? { get }
    var imageUrl: String? { get }
}

struct ComicCellPorperties: ComicsCellViewProperiesProtocol, Identifiable {
    var id = UUID()
    
    let title: String?
    internal let issue: Int?
    internal let imageUrl: String?
    
    var issueFormatted: String? {
        get {
            if let num = issue {
                return "# \(num)"
            }
            return nil
        }
    }
    
    func imageResource() -> Resource? {
        guard let urlString = imageUrl else { return nil }
        #warning("Improve caching policy later")
        
        if urlString.isValidURL {
            if let url = URL(string: urlString) {
                /* Cached image resource */
                return ImageResource(downloadURL: url)
            }
        }
        
        return nil
    }
}
