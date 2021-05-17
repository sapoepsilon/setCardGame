//
//  setCardGameView.swift
//  setCardGame
//
//  Created by Ismatulla Mansurov on 5/10/21.
//

import SwiftUI

struct SetCardGameView: View {
    @ObservedObject var viewModel: SetCardGameViewModel
    @State var isGameStarted: Bool = false
    
    
    var body: some View {
        VStack {
            if isGameStarted {
                Grid(viewModel.cards){ card in
                    CardView(card: card, viewModel: viewModel)
                       
                 
                                .onTapGesture {
                                self.viewModel.choose(card: card)
                                
                                }
                        .scaleEffect(card.isChosen ? 1.05 : 1)
                }
                .padding()
                .transition(AnyTransition.offset(x: 2300, y:2000))
                .animation(.easeOut(duration: 0.5))
            }
            Button(action: viewModel.addCards) {
                Text("Deal cards")
            }
        }.onAppear(){
            isGameStarted.toggle()
        }
    }
}

struct CardView: View {
    var card: SetCardGameModel.Card
    var viewModel: SetCardGameViewModel
    
    var body: some View {
        GeometryReader{ geometry in
            body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {

            RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth).foregroundColor(card.isChosen ? .blue : cardColor(card: card))

                if ( card.shapeNumbers  == 1) {
                    VStack{
                        getView(card: card).foregroundColor(cardColor(card: card))
                    }.padding()
                }
                 else if( card.shapeNumbers == 2){

                        VStack {

                            getView(card: card).foregroundColor(cardColor(card: card)).aspectRatio(contentMode: .fit)
                            getView(card: card).foregroundColor(cardColor(card: card)).aspectRatio(contentMode: .fit)
                            

                            }.padding(5)

                } else if(card.shapeNumbers == 3){
                        VStack {
                            getView(card: card).foregroundColor(cardColor(card: card)).aspectRatio(contentMode: .fit)
                            getView(card: card).foregroundColor(cardColor(card: card)).aspectRatio(contentMode: .fit)
                            getView(card: card).foregroundColor(cardColor(card: card)).aspectRatio(contentMode: .fit)


                        }.padding(5)



        }
        }
        .padding(5)
        .font(Font.system(size: fontSize(for: size)))
        
    }
    
    // MARK:  --Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    let fontScaleFactor: CGFloat = 0.8
    
    func cardColor(card: SetCardGameModel.Card) -> Color {
        

        if card.color == 1 {
            return Color.red
        } else if card.color == 2 {
            return Color.green
        } else if card.color == 3  {
            return Color.yellow
        }  else {
            return Color.blue
        }
    }

   func getView(card: SetCardGameModel.Card) -> AnyView{
        let shape = card.shape
    let opacity: Double =  Double(card.fill)
    
    // if card content is just stroke than return just the outline of the shape
    
    if(card.fill == 1) {

    if shape == 1 {
        return AnyView(Diamond().stroke(lineWidth: edgeLineWidth))
    } else if shape == 2 {
        return AnyView(Squiggle().stroke(lineWidth: edgeLineWidth))
    } else if shape == 3{
        return AnyView(Capsule().stroke(lineWidth: edgeLineWidth))
    } else {
        return AnyView(Squiggle().stroke(lineWidth: edgeLineWidth))
    }
        
        // else return card content with two different opacities depending on the id of "Fill" property of the given card
    
    } else {
        if shape == 1 {
            return AnyView(Diamond().opacity(opacity - 1.5))
        } else if shape == 2 {
            return AnyView(Squiggle().opacity(opacity - 1.5))
        } else if shape == 3{
            return AnyView(Pie(startAngle: Angle(degrees: 180), endAngle: Angle(degrees: -180)).opacity(opacity - 1.5))
        } else {
            return AnyView(Pie(startAngle: Angle(degrees: 180), endAngle: Angle(degrees: -180)).opacity(opacity - 1.5).opacity(opacity - 1.5))
        }
    }
    
    
    
    
    }
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
    

    
}



struct setCardGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetCardGameView(viewModel: SetCardGameViewModel())
    }
}

