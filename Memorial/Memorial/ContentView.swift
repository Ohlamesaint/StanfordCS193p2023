//
//  ContentView.swift
//  Memorial
//
//  Created by SamLS Chen on 2024/7/23.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["🎃", "👻", "🕷️", "🐍", "🍖", "🌶️", "⛩️", "🗿", "🗽"]
    @State var cardNumber: Int = 3
    var body: some View {
        VStack {
            ScrollView{
                cards
            }
            Spacer()
            cardCountAdjusters
        }.padding()
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }.imageScale(.large).font(.largeTitle)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0...cardNumber, id: \.self) {
                index in CardView(content: emojis[index]).aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(.orange)

    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(
            action: {
                if(cardNumber+offset<emojis.count && cardNumber+offset>=0) {
                    cardNumber += offset
                }
            },
            label: {Image(systemName: symbol)
            }
        ).disabled(cardNumber+offset>=emojis.count || cardNumber+offset<0)
    }
}

struct CardView: View {
    @State var isFaceUp = false
    let content: String;
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 15.0)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
