//
//  News_SwiftUIApp.swift
//  Shared
//
//  Created by Lilia Chmola on 21.02.2021.
//

import SwiftUI

@main
struct News_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            NewsListView(viewModel: NewsListVM())
        }
    }
}
