//
//  SetGameView.swift
//  SetGame
//
//  Created by Dmitry Reshetnik on 10.03.2021.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    @State var cardsOnScreen: [SetCard] = []
    
    var body: some View {
        Grid(cardsOnScreen) { card in
            CardView(card: card)
        }
        .onAppear(perform: {
            for _ in 1...12 {
                cardsOnScreen.append(viewModel.deck.removeFirst())
            }
        })
    }
}

struct CardView: View {
    var card: SetCard
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 2)
            Text("This is Set card with \(card.number) \(card.color) \(card.shading) \(card.shape)'s.")
        }
        .padding(5)
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}
