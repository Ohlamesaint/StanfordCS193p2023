//
//  MemorialApp.swift
//  Memorial
//
//  Created by SamLS Chen on 2024/7/23.
//

import SwiftUI

@main
struct MemorialApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
