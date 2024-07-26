//
//  EmojiMemoryGameView.swift
//  Memorial
//
//  Created by SamLS Chen on 2024/7/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    let themes: Array<Array<String>> = [
        ["🛺", "⛴️", "🚀", "🏎️", "🛩️", "🚅", "🛵", "🚟", "🛺", "⛴️", "🚀", "🏎️", "🛩️", "🚅", "🛵", "🚟"],
        ["⛹️", "🏌🏻", "🚣🏻‍♀️", "🤺", "🏄🏻‍♀️", "🏋🏻", "🏊🏻‍♂️", "⛹️", "🏌🏻", "🚣🏻‍♀️", "🤺", "🏄🏻‍♀️", "🏋🏻", "🏊🏻‍♂️"],
        ["🦒", "🦢", "🦞", "🦈", "🐀", "🐈", "🐇", "🐫", "🦧", "🐘", "🐨", "🦒", "🦢", "🦞", "🦈", "🐀", "🐈", "🐇", "🐫", "🦧", "🐘", "🐨"]
    ]
    @State var currentTheme: Int = 0
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView{
                cards
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: viewModel.cards)
            }
            Spacer()
            HStack{
                Spacer()
                vehiclesTheme
                Spacer()
                sportsTheme
                Spacer()
                animalsTheme
                Spacer()
            }
            Button(action: {viewModel.shuffle()}, label: {Text("shuffle")})
        }.padding()
        
    }
    
    var vehiclesTheme: some View {
        themeChanger(to: 0, imageName: "car", name: "Vehicles")
    }
    var sportsTheme: some View {
        themeChanger(to: 1, imageName: "figure.walk", name: "Sports")
    }
    var animalsTheme: some View {
        themeChanger(to: 2, imageName: "hare", name: "Animals")
    }
    
    func themeChanger(to themeNumber: Int, imageName: String, name: String) -> some View {
        Button(action: {currentTheme = themeNumber}, label: {
            VStack{
                Image(systemName: imageName).imageScale(.large).font(.title2)
                Text(name).font(.caption)
            }
        })
    }

    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65), spacing: 0.0)], spacing: 0.0) {
            ForEach(viewModel.cards, id: \.self) {
                card in CardView(card)
                    .padding(4)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }.foregroundColor(.red)

    }
}

struct CardView: View {
    let card: MemoryGameModel<String>.Card
    
    init(_ card: MemoryGameModel<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 15.0)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1.0, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
