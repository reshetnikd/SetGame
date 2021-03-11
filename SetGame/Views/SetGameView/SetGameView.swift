//
//  SetGameView.swift
//  SetGame
//
//  Created by Dmitry Reshetnik on 10.03.2021.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    
    var body: some View {
        Group {
            Button("New Game") {
                startNewGame()
            }
            Grid(viewModel.dealt) { card in
                CardView(content: card)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
                    .aspectRatio(2/3, contentMode: .fit)
            }
            .onAppear {
                startNewGame()
            }
            Button("Deal") {
                viewModel.deal()
            }
        }
    }
    
    private func startNewGame() {
        withAnimation {
            viewModel.restartGame()
            for _ in 1...12 {
                viewModel.dealt.append(viewModel.deck.removeFirst())
            }
        }
    }
}

struct CardView: View {
    var content: SetCard
    
    
    var body: some View {
        ZStack {
            switch content.status {
                case SetCard.Status.selected.rawValue:
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 4)
                    Text("This is Set card with \(content.number) \(content.color) \(content.shading) \(content.shape)'s.")
                case SetCard.Status.unselected.rawValue:
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                    Text("This is Set card with \(content.number) \(content.color) \(content.shading) \(content.shape)'s.")
                case SetCard.Status.matched.rawValue:
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.green, lineWidth: 4)
                    Text("This is Set card with \(content.number) \(content.color) \(content.shading) \(content.shape)'s.")
                case SetCard.Status.mismatched.rawValue:
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red, lineWidth: 4)
                    Text("This is Set card with \(content.number) \(content.color) \(content.shading) \(content.shape)'s.")
                default:
                    EmptyView()
            }
//            if content.status == SetCard.Status.selected.rawValue {
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(Color.white)
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(lineWidth: 8)
//                Text("This is Set card with \(content.number) \(content.color) \(content.shading) \(content.shape)'s.")
//            } else {
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(Color.white)
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(lineWidth: 2)
//                Text("This is Set card with \(content.number) \(content.color) \(content.shading) \(content.shape)'s.")
//            }
        }
        .padding(5)
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}
