//
//  ComicCell.swift
//  Shortcutter
//
//  Created by Armands Berzins on 13/11/2022.
//

import Foundation

struct ComicCell: View {
    let properties: ComicCellPorperties
    
    var body: some View {
        Text(properties.title ?? "")
    }
}
