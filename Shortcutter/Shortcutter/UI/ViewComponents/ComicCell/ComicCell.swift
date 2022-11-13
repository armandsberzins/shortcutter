//
//  ComicCell.swift
//  Shortcutter
//
//  Created by Armands Berzins on 13/11/2022.
//

import Foundation
//import Nuke
import SwiftUI
//import NukeUI
import Kingfisher

struct ComicCell: View {
    let properties: ComicCellPorperties
    
    var body: some View {
        VStack(alignment: .leading) {
            makeHeader
            makeImage
        }
    }
    
    @ViewBuilder var makeHeader: some View {
        HStack(alignment: .top) {
            if let title = properties.title {
                Text(title)
            }
            Spacer()
            if let issueNumber = properties.issueFormatted {
                Text(issueNumber)
            }
        }.font(Font.title3)
    }
    
    @ViewBuilder var makeImage: some View {
        if let imageResource = properties.imageResource() {
            KFImage(source: .network(imageResource))
                .placeholder({
                    ProgressView()
                })
                .downsampling(size: CGSize(width: 400, height: 400))
                .resizable()
                .frame(maxHeight: 220)
                .cornerRadius(8)
        }
    }
}
