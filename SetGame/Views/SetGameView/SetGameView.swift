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
                    CardSymbol(content: content)
//                    Text("This is Set card with \(content.number.rawValue) \(content.color.rawValue) \(content.shading.rawValue) \(content.shape.rawValue)'s.")
                case .unselected:
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 2)
                    CardSymbol(content: content)
//                    Text("This is Set card with \(content.number.rawValue) \(content.color.rawValue) \(content.shading.rawValue) \(content.shape.rawValue)'s.")
                case .matched:
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.green, lineWidth: 4)
                    CardSymbol(content: content)
//                    Text("This is Set card with \(content.number.rawValue) \(content.color.rawValue) \(content.shading.rawValue) \(content.shape.rawValue)'s.")
                case .mismatched:
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red, lineWidth: 4)
                    CardSymbol(content: content)
//                    Text("This is Set card with \(content.number.rawValue) \(content.color.rawValue) \(content.shading.rawValue) \(content.shape.rawValue)'s.")
            }
        }
        .padding(5)
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
                     Stripes()
                        .stroke()
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        .mask(usedSymbol.stroke().frame(width: geometry.size.width/2, height: geometry.size.height/2, alignment: .center))
                } else if isSolid {
                    usedSymbol.fill(usedColor)
                } else {
                    usedSymbol.stroke(usedColor)
                }
            case .two:
                if isStripped {
                    VStack {
                        Stripes()
                            .stroke()
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            .mask(usedSymbol.stroke().frame(width: geometry.size.width/4, height: geometry.size.height/4, alignment: .center))
                        Stripes()
                            .stroke()
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            .mask(usedSymbol.stroke().frame(width: geometry.size.width/4, height: geometry.size.height/4, alignment: .center))
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
                        Stripes()
                            .stroke()
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            .mask(usedSymbol.stroke().frame(width: geometry.size.width/6, height: geometry.size.height/6, alignment: .center))
                        Stripes()
                            .stroke()
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            .mask(usedSymbol.stroke().frame(width: geometry.size.width/6, height: geometry.size.height/6, alignment: .center))
                        Stripes()
                            .stroke()
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            .mask(usedSymbol.stroke().frame(width: geometry.size.width/6, height: geometry.size.height/6, alignment: .center))
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
