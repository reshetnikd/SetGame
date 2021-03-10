//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Dmitry Reshetnik on 10.03.2021.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published private var setGame = SetGame()
    
    // MARK: - Access to the Model
    
    var deck: [SetCard] {
        get {
            setGame.playingSetCardDeck
        }
        set {
            setGame.playingSetCardDeck = newValue
        }
    }
    
    var dealt: [SetCard] {
        get {
            setGame.dealtCards
        }
        set {
            setGame.dealtCards = newValue
        }
    }
    
    var selected: [SetCard] {
        get {
            setGame.selectedCards
        }
        set {
            setGame.selectedCards = newValue
        }
    }
    
    var matched: [SetCard] {
        get {
            setGame.matchedCards
        }
        set {
            setGame.matchedCards = newValue
        }
    }
    
    // MARK: - Intent
    
    func choose(_ card: SetCard) {
        setGame.choose(card)
    }
    
    func restartGame() {
        setGame.dealtCards.removeAll()
        setGame = SetGame()
    }
    
    func deal() {
        setGame.dealSetCard()
    }
    
    func checkMatchOf() {
        setGame.checkSetCards(from: selected)
    }
}
