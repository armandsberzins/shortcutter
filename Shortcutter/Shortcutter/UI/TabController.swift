//
//  TabController.swift
//  Shortcutter
//
//  Created by Armands Berzins on 10/11/2022.
//

import Foundation
import SwiftUI

class TabController: ObservableObject {
    @Published var activeTab = Tab.home
    
    func open(_ tab: Tab) {
        activeTab = tab
    }
}

enum Tab {
    case home
    case favourites
}
