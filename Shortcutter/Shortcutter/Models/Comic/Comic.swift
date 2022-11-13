//
//  Comic.swift
//  Shortcutter
//
//  Created by Armands Berzins on 10/11/2022.
//

import Foundation

struct Comic: Codable {    
    let month: String?
    let num: Int?
    let link, year, news, safeTitle: String?
    let transcript, alt: String?
    let img: String?
    let title, day: String?

    enum CodingKeys: String, CodingKey {
        case month, num, link, year, news
        case safeTitle = "safe_title"
        case transcript, alt, img, title, day
    }
}
