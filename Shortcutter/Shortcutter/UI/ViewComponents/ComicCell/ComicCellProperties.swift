//
//  ComicCellProperties.swift
//  Shortcutter
//
//  Created by Armands Berzins on 13/11/2022.
//

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
    let issue: Int?
    let imageUrl: String?
    
    var issueFormatted: String? {
        get {
            if let num = issue {
                return String(num)
            }
            return nil
        }
    }
}
