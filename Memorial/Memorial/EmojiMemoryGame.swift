//
//  EmojiMemoryGame.swift
//  Memorial
//
//  Created by SamLS Chen on 2024/7/26.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    // use class because it's gonna to be shared amoungst everything
    
    private static let theme = ["🛺", "⛴️", "🚀", "🏎️", "🛩️", "🚅", "🛵", "🚟", "🛺", "⛴️", "🚀", "🏎️", "🛩️", "🚅", "🛵", "🚟"]
    
    private static func createMemoryGame() -> MemoryGameModel<String> {
        MemoryGameModel(numberOfPairs: 80){
            index in
                if index<theme.count {
                    return theme[index]
                }
                else {
                    return "🤯"
                }
            
        }
    }
    
    @Published private var model: MemoryGameModel<String> = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGameModel<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() -> Void {
        model.shuffle()
    }
    
    // user intent function
    func choose(_ card: MemoryGameModel<String>.Card) {
        self.model.choose(card)
    }
    
    func chooseTheme(_ themeNumber: Int) {
        
    }
}
