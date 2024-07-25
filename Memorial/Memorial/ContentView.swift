//
//  ContentView.swift
//  Memorial
//
//  Created by SamLS Chen on 2024/7/23.
//

import SwiftUI

struct ContentView: View {
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
            ForEach(themes[currentTheme].indices.shuffled(), id: \.self) {
                index in CardView(content: themes[currentTheme][index]).aspectRatio(2/3, contentMode: .fit)
            }
        }.foregroundColor(.red)

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
