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
        VStack {
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
    
    // MARK: - Layout Constants
    
    private let paddingLength: CGFloat = 5.0
    private let radius: CGFloat = 10.0
    private let width: CGFloat = 4.0
    
    
    var body: some View {
        ZStack {
            switch content.status {
                case .selected:
                    RoundedRectangle(cornerRadius: radius)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(lineWidth: width)
                    CardSymbol(content: content)
                        .padding(paddingLength)
                case .unselected:
                    RoundedRectangle(cornerRadius: radius)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(lineWidth: width/2)
                    CardSymbol(content: content)
                        .padding(paddingLength)
                case .matched:
                    RoundedRectangle(cornerRadius: radius)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color.green, lineWidth: width)
                    CardSymbol(content: content)
                        .padding(paddingLength)
                case .mismatched:
                    RoundedRectangle(cornerRadius: radius)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color.red, lineWidth: width)
                    CardSymbol(content: content)
                        .padding(paddingLength)
            }
        }
        .padding(paddingLength)
    }
}

struct CardSymbol: View {
    struct AnyShape: Shape {
        private let builder: (CGRect) -> Path
        
        init<S: Shape>(_ shape: S) {
            builder = { rect in
                let path = shape.path(in: rect)
                return path
            }
        }
        
        func path(in rect: CGRect) -> Path {
            return builder(rect)
        }
    }
    
    let content: SetCard
    
    var isStripped: Bool {
        content.shading == .striped
    }
    
    var isSolid: Bool {
        content.shading == .solid
    }
    
    var usedColor: Color {
        switch content.color {
            case .green:
                return Color.green
            case .purple:
                return Color.purple
            case .red:
                return Color.red
        }
    }
    
    var usedSymbol: AnyShape {
        switch content.shape {
            case .diamond:
                return AnyShape(Diamond())
            case .oval:
                return AnyShape(Oval())
            case .squiggle:
                return AnyShape(Squiggle())
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            createSymbol(with: geometry)
        }
    }
    
    @ViewBuilder
    private func createSymbol(with geometry: GeometryProxy) -> some View {
        switch content.number {
            case .one:
                if isStripped {
                     usedSymbol
                        .stroke(usedColor)
                        .mask(Stripes().stroke().frame(width: geometry.size.width, height: geometry.size.height, alignment: .center))
                } else if isSolid {
                    usedSymbol.fill(usedColor)
                } else {
                    usedSymbol.stroke(usedColor)
                }
            case .two:
                if isStripped {
                    VStack {
                        usedSymbol
                            .stroke(usedColor)
                            .mask(Stripes().stroke().frame(width: geometry.size.width, height: geometry.size.height, alignment: .center))
                        usedSymbol
                            .stroke(usedColor)
                            .mask(Stripes().stroke().frame(width: geometry.size.width, height: geometry.size.height, alignment: .center))
                    }
                } else if isSolid {
                    VStack {
                        usedSymbol
                            .fill(usedColor)
                        usedSymbol
                            .fill(usedColor)
                    }
                } else {
                    VStack {
                        usedSymbol
                            .stroke(usedColor)
                        usedSymbol
                            .stroke(usedColor)
                    }
                }
            case .three:
                if isStripped {
                    VStack {
                        usedSymbol
                            .stroke(usedColor)
                            .mask(Stripes().stroke().frame(width: geometry.size.width, height: geometry.size.height, alignment: .center))
                        usedSymbol
                            .stroke(usedColor)
                            .mask(Stripes().stroke().frame(width: geometry.size.width, height: geometry.size.height, alignment: .center))
                        usedSymbol
                            .stroke(usedColor)
                            .mask(Stripes().stroke().frame(width: geometry.size.width, height: geometry.size.height, alignment: .center))
                    }
                } else if isSolid {
                    VStack {
                        usedSymbol
                            .fill(usedColor)
                        usedSymbol
                            .fill(usedColor)
                        usedSymbol
                            .fill(usedColor)
                    }
                } else {
                    VStack {
                        usedSymbol
                            .stroke(usedColor)
                        usedSymbol
                            .stroke(usedColor)
                        usedSymbol
                            .stroke(usedColor)
                    }
                }
        }
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}
