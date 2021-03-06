//
//  SetGame.swift
//  SetGame
//
//  Created by Dmitry Reshetnik on 10.03.2021.
//
//  A set consists of three cards satisfying all of these conditions:
//  - They all have the same number or have three different numbers.
//  - They all have the same shape or have three different shapes.
//  - They all have the same shading or have three different shadings.
//  - They all have the same color or have three different colors.

import Foundation

struct SetGame {
    var playingSetCardDeck: [SetCard] = []
    var selectedCards: [SetCard] = []
    var matchedCards: [SetCard] = []
    var dealtCards: [SetCard] = []
    var isMatchedAsSet: Bool = false
    
    /// Select chosen card.
    mutating func choose(_ card: SetCard) {
        if let chosenIndex = dealtCards.firstIndex(matching: card) {
            if selectedCards.count == 3 {
                if isMatchedAsSet && card.status == .matched {
                    // No card should be selected.
                    return
                } else {
                    if isMatchedAsSet {
                        dealSetCard()
                    } else {
                        // Deselect 3 non-matching cards.
                        for index in selectedCards.indices {
                            if let deselectedIndex = dealtCards.firstIndex(matching: selectedCards[index]) {
                                dealtCards[deselectedIndex].status = .unselected
                            }
                        }
                    }
                    // Select chosen card.
                    selectedCards.removeAll()
                    selectedCards.append(card)
                    dealtCards[chosenIndex].status = .selected
                }
            } else {
                // Deselect currently selected card either select new one.
                if card.status == .selected {
                    var tempCard = card
                    tempCard.status = .unselected
                    dealtCards[chosenIndex].status = .unselected
                    selectedCards.removeAll { $0 == tempCard }
                } else {
                    selectedCards.append(card)
                    
                    if selectedCards.count == 3 {
                        checkSetCards(from: selectedCards)
                        
                        for index in selectedCards.indices {
                            if matchedCards.contains(selectedCards[index]) {
                                if let matchedIndex = dealtCards.firstIndex(matching: selectedCards[index]) {
                                    dealtCards[matchedIndex].status = .matched
                                    isMatchedAsSet = true
                                    if playingSetCardDeck.isEmpty {
                                        // Remove matched cards if no more cards in Playing Deck.
                                        dealtCards.remove(at: matchedIndex)
                                    }
                                }
                            } else {
                                if let mismatchedIndex = dealtCards.firstIndex(matching: selectedCards[index]) {
                                    dealtCards[mismatchedIndex].status = .mismatched
                                    isMatchedAsSet = false
                                }
                            }
                        }
                    } else {
                        // Select chosen card.
                        dealtCards[chosenIndex].status = .selected
                    }
                }
            }
        }
    }
    
    /// Checking if selected cards are match according to game of Set rules.
    mutating func checkSetCards(from selected: [SetCard]) {
        if selected.count == 3 {
            if (((selected[0].number == selected[1].number) && (selected[1].number == selected[2].number)) || ((selected[0].number != selected[1].number) && (selected[0].number != selected[2].number) && (selected[1].number != selected[2].number))) && (((selected[0].shading == selected[1].shading) && (selected[1].shading == selected[2].shading)) || ((selected[0].shading != selected[1].shading) && (selected[0].shading != selected[2].shading) && (selected[1].shading != selected[2].shading))) && (((selected[0].color == selected[1].color) && (selected[1].color == selected[2].color)) || ((selected[0].color != selected[1].color) && (selected[0].color != selected[2].color) && (selected[1].color != selected[2].color))) && (((selected[0].shape == selected[1].shape) && (selected[1].shape == selected[2].shape)) || ((selected[0].shape != selected[1].shape) && (selected[0].shape != selected[2].shape) && (selected[1].shape != selected[2].shape))) {
//            if true { // for testing purpose
                for index in selected.indices {
                    matchedCards.append(selected[index])
                }
            }
        }
    }
    
    /// Replace the selected cards if they are match or add 3 cards to the game.
    mutating func dealSetCard() {
        var deal: [SetCard] = []
        
        if selectedCards.count == 3, !playingSetCardDeck.isEmpty {
            for index in selectedCards.indices {
                if matchedCards.contains(selectedCards[index]) {
                    if let matchedIndex = dealtCards.firstIndex(matching: selectedCards[index]) {
                        dealtCards[matchedIndex] = playingSetCardDeck.removeFirst()
                        isMatchedAsSet = false
                    } else {
                        deal.append(playingSetCardDeck.removeFirst())
                    }
                } else {
                    deal.append(playingSetCardDeck.removeFirst())
                }
            }
        } else if !playingSetCardDeck.isEmpty {
            for _ in 0...2 {
                deal.append(playingSetCardDeck.removeFirst())
            }
        }
        
        dealtCards += deal
    }
    
    /// Create deck of 81 SetCard's.
    init() {
        for number in SetCard.Number.all {
            for shape in SetCard.Shape.all {
                for shade in SetCard.Shading.all {
                    for color in SetCard.Color.all {
                        playingSetCardDeck.append(SetCard(number: number, shape: shape, shading: shade, color: color, status: .unselected))
                    }
                }
            }
        }
        playingSetCardDeck.shuffle()
    }
}
