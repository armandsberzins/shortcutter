//
//  OfflineDataManager.swift
//  Shortcutter
//
//  Created by Armands Berzins on 13/11/2022.
//

import Foundation

struct ComicStorage {
    
    static func save(_ comic: Comic) {
        do {
            guard let cachekey = cacheUrl(comic.num) else { return }
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(comic)
            let jsonString = String(data: jsonData, encoding: .utf8)
            try jsonString?.write(to: cachekey, atomically: true, encoding: .utf8)
        } catch {
            print("Error: Cahce failed to save")
        }
    }
    
    static func loadComic(for issueNumber: Int?) -> Comic? {
        do {
            guard let num = issueNumber else { return nil }
            guard let cachekey = cacheUrl(num) else { return nil }
            let data = try Data(contentsOf: cachekey)
            let decoder = JSONDecoder()
            let comicData = try decoder.decode(Comic.self, from: data)
            print("Cahce: Comics loaded from cache")
            return comicData
        } catch {
            print("Error: Cloudn't load from cahce")
            return nil
        }
    }
    
    static private func cacheUrl(_ issueNumber: Int?) -> URL? {
        guard let issue = issueNumber else { return nil }
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("ComicCache-\(issue).json")
    }
    
}
