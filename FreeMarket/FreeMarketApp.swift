//
//  DopeWarsApp.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/10/20.
//

import SwiftUI

@main
struct DopeWarsApp: App {
  var marketplace = MarketPlace(
    gameWithItems: FreeMarketItem.demoItems,
    minMarketPlaceItems: 6)
  @StateObject private var playerStats: Player = Player(startingCash: 2000, startingDebt: 5500, startingHealth: 100)
    var body: some Scene {
        WindowGroup {
          ContentView(marketPlace: marketplace)
              .environmentObject(playerStats)
          
        }
    }
}
