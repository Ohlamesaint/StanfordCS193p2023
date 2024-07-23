//
//  ContentView.swift
//  Memorial
//
//  Created by SamLS Chen on 2024/7/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: false)
            CardView(isFaceUp: true)
            CardView(isFaceUp: false)
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = true
    
    var body: some View {
        ZStack(content: {
            if(isFaceUp) {
                RoundedRectangle(cornerRadius: 15.0).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 15.0).strokeBorder(lineWidth: 2)
                Text("👻").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 15.0)
            }
        })
    }
}

#Preview {
    ContentView()
}
