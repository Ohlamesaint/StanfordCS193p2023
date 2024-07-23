//
//  ContentView.swift
//  Memorial
//
//  Created by SamLS Chen on 2024/7/23.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["🎃", "👻", "🕷️", "🐍"]
    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self) {
                index in CardView(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    @State var isFaceUp = false
    let content: String;
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 15.0)
            if(isFaceUp) {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
