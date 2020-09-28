//  VIEW
//
//  EmojieMemoryGameView.swift
//
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Text("Animals")
            .font(.largeTitle).padding()
        HStack {
            Text("Score: 12")
                .font(.body).bold().padding(8.0)
            
            Button(action: {
                print("NEW GAME")
            }) {
                Text("NEW GAME")
                    .font(.body).bold().padding(8.0)
                    .overlay(RoundedRectangle(cornerRadius: 35.0).stroke(lineWidth: 2.0))
            }
        }
        
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture{
                viewModel.choose(card: card)
            }
            .padding(5)
        }
        .padding()
        .foregroundColor(Color.red)
    }
}


struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched{
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
        }.font(Font.system(size: fontSize(for: size)))
    }
    
    
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
