//
//  SetCardGameModel.swift
//  setCardGame
//
//  Created by Ismatulla Mansurov on 5/10/21.
//

import Foundation

struct SetCardGameModel {

    
    private (set) var cards: Array<Card>
    var dealtCardAmount: Int = 12
    var chosenCards: Int = 0
    var firstCard: Card
    var secondCard: Card
    
    
    mutating func choose(card: Card) {
        let chosenCard = cards.firstIndex(matching: card)
       // cards.remove(at: chosenCard!)
        
        print(chosenCards)
        if (chosenCards <= 2) {
        
            cards[chosenCard!].isChosen.toggle()
            if card.isChosen {
                chosenCards -= 1
            } else {

                if(chosenCards == 0) {
                    firstCard = card
                    print("first card \(firstCard)" )
                    chosenCards += 1
                } else if(chosenCards == 1) {
                    secondCard = card
                    print("second card \(secondCard)" )
                    chosenCards += 1
                } else {
                    print(card)
                    removeSet(firstCard: firstCard, secondCard: secondCard, thirdCard: card)
                }
             
            }
           
        } else if(card.isChosen) {
            chosenCards -= 1
            cards[chosenCard!].isChosen.toggle()
        }
    }
    
    
    mutating func removeSet(firstCard: Card, secondCard: Card, thirdCard: Card) {
        
        
        if(firstCard.color == secondCard.color && firstCard.color == secondCard.color) {
        
            cards.remove(at: cards.firstIndex(matching: firstCard)!)
            cards.remove(at: cards.firstIndex(matching: secondCard)!)
            cards.remove(at: cards.firstIndex(matching: thirdCard)!)
            chosenCards = 0
        }else if(firstCard.shape == secondCard.shape && firstCard.shape == thirdCard.shape) {
            cards.remove(at: cards.firstIndex(matching: firstCard)!)
            cards.remove(at: cards.firstIndex(matching: secondCard)!)
            cards.remove(at: cards.firstIndex(matching: thirdCard)!)
            chosenCards = 0
        }
    }
    
    
    init (numberOfSets: Int){
        cards = Array<Card>()
        var shape: Int = 1
        var color: Int = 0
        var fill: Int = 1
        var shapeNumber: Int = 1
        for tripleIndex in 1...numberOfSets {
            
            calculateID(shapeCalculate: shape, colorCalculate: color, shapeNumbersCalculate: shapeNumber, fillCalculate: fill)
            
            cards.append(Card(id: tripleIndex*3 , shape: shape , color: color, shapeNumbers: shapeNumber, fill: fill ))
            shape += 1
            cards.append(Card(id:tripleIndex * 3 + 1, shape: shape, color: color, shapeNumbers: shapeNumber, fill: fill ))
            shape += 1
            cards.append(Card(id:tripleIndex * 3 + 2 , shape: shape , color: color, shapeNumbers: shapeNumber ,  fill: fill ))
            
            
            cards.shuffle()
        }
        
        func calculateID(shapeCalculate: Int, colorCalculate: Int, shapeNumbersCalculate: Int, fillCalculate: Int){
            
            shape = 1
            color += 1
            
            if(colorCalculate == 3) {
                shapeNumber += 1
                color = 1
                
                if (shapeNumbersCalculate == 3) {
                    shapeNumber = 1
                    fill += 1
                    
                    if (fillCalculate == 3 ) {
                        fill = 1
                    }
                }
            }
        }
        
        firstCard = cards[0]
        secondCard = cards[1]
        
    }
    
    mutating func addCards() {
        if( dealtCardAmount < 82) {
            dealtCardAmount += 3
        }
    }
    
    
    func dealCards(Cards: Array<Card>) -> ( Array<Card>) {
        
        var dealtCards = Array<Card>()
        
        for dealtCard in Cards.prefix(dealtCardAmount) {
            
            dealtCards.append(dealtCard)
        }
        
        return dealtCards
        
    }
    
    struct Card : Identifiable {
        var isChosen: Bool = false
        var isSet: Bool = false
        var id: Int = 0
        var hasSeen: Int = 0
        var shape: Int
        var color: Int
        var shapeNumbers: Int
        var fill: Int
    }
}
