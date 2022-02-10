//
//  demoPlayer.swift
//  DopeWars
//
//  Created by Anthony Correa on 11/4/20.
//

import Foundation

extension Player {
  
  public static let demoPlayer: Player = {
    let player = Player(startingCash: 2000, startingDebt: 5500, startingHealth: 100)
    player.buy(FreeMarketItem.demoItem, quantity: 10, atPrice: 100)
    return player
  }()
  
}
