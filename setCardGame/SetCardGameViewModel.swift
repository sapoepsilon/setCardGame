//
//  SetCardGameViewModel.swift
//  setCardGame
//
//  Created by Ismatulla Mansurov on 5/10/21.
//

import SwiftUI


class SetCardGameViewModel: ObservableObject {
    
    @Published private var model: SetCardGameModel = SetCardGameViewModel.createGame()
    
    private static func createGame() -> SetCardGameModel {
        
        SetCardGameModel(numberOfSets: 27)
    }
        
        

   
    
    
var cards: Array<SetCardGameModel.Card> {
    model.dealCards(Cards: model.cards)
    }
    
    var cardDeck: Array<SetCardGameModel.Card> {
        model.cards
    }
    
    var dealtCard: Int {
        model.dealtCard
    }
    
    func choose(card: SetCardGameModel.Card) {
        model.choose(card: card)
    }
    
    func addCards() {
        model.addCards()
    }
    
    func newGame() {
        model = SetCardGameViewModel.createGame()
    }
}




