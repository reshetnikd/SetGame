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
                withAnimation(.easeInOut) {
                    startNewGame()
                }
            }
            Grid(viewModel.dealt) { card in
                CardView(content: card)
                    .transition(.offset(CGSize(width: Int.random(in: 256...512), height: Int.random(in: 256...512))))
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            viewModel.choose(card)
                        }
                    }
                    .aspectRatio(2/3, contentMode: .fit)
            }
            .onAppear {
                withAnimation(.easeInOut) {
                    startNewGame()
                }
            }
            Button("Deal More Cards") {
                withAnimation(.easeInOut) {
                    viewModel.deal()
                }
            }
            .disabled(viewModel.deck.isEmpty)
        }
    }
    
    private func startNewGame() {
        viewModel.restartGame()
        for _ in 1...12 {
            viewModel.dealt.append(viewModel.deck.removeFirst())
        }
    }
}

struct CardView: View {
    var content: SetCard
    
    
    var body: some View {
        ZStack {
            switch content.status {
                case .selected:
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 4)
                    Text("This is Set card with \(content.number.rawValue) \(content.color.rawValue) \(content.shading.rawValue) \(content.shape.rawValue)'s.")
                case .unselected:
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                    Text("This is Set card with \(content.number.rawValue) \(content.color.rawValue) \(content.shading.rawValue) \(content.shape.rawValue)'s.")
                case .matched:
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.green, lineWidth: 4)
                    Text("This is Set card with \(content.number.rawValue) \(content.color.rawValue) \(content.shading.rawValue) \(content.shape.rawValue)'s.")
                case .mismatched:
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red, lineWidth: 4)
                    Text("This is Set card with \(content.number.rawValue) \(content.color.rawValue) \(content.shading.rawValue) \(content.shape.rawValue)'s.")
            }
        }
        .padding(5)
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}
