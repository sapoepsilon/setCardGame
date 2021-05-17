//
//  setCardGameApp.swift
//  setCardGame
//
//  Created by Ismatulla Mansurov on 5/10/21.
//

import SwiftUI

@main
struct setCardGameApp: App {
    var body: some Scene {
        WindowGroup {
            let game = SetCardGameViewModel()
            SetCardGameView(viewModel: game)
            
        }
    }
}
