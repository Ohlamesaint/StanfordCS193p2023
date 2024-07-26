//
//  MemorizeGame.swift
//  Memorial
//
//  Created by SamLS Chen on 2024/7/26.
//

import Foundation

struct MemoryGameModel<CardContent> where CardContent: Equatable {

    private(set) var cards: [Card]
    
    private var firstCard: Int? = nil
    
    init (numberOfPairs: Int, cardFactory: (Int) -> CardContent) {
        cards = []
        for index in 0..<max(2, numberOfPairs) {
            cards.append(Card(content: cardFactory(index), id: "\(index)"))
            cards.append(Card(content: cardFactory(index), id: "-\(index)"))
        }
    }

    // card is implicitly a let
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            
            // card already face up
            if(cards[chosenIndex].isFaceUp){
                return
            }
            
            cards[chosenIndex].isFaceUp = true
            if let _ = firstCard {
                if(cards[chosenIndex].content == cards[firstCard!].content) {
                    cards[chosenIndex].isMatched = true
                    cards[firstCard!].isMatched = true
                } else {
                    cards[chosenIndex].isFaceUp = false
                    cards[firstCard!].isFaceUp = false
                }
                firstCard = nil
            } else {
                firstCard = chosenIndex
            }
            
        } else {
            print("card not found")
        }
        
    }
    
    mutating func shuffle() -> Void {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, Hashable, CustomDebugStringConvertible{
        
        static func == (lhs: MemoryGameModel<CardContent>.Card, rhs: MemoryGameModel<CardContent>.Card) -> Bool {
            return lhs.isFaceUp == rhs.isFaceUp &&
            lhs.isMatched == rhs.isMatched &&
            lhs.content == rhs.content &&
            lhs.id == rhs.id
        }
        
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(self.id)
        }
        
        var debugDescription: String {"\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "not matched")"}

    }
}
