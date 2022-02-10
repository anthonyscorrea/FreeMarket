//
//  GameController.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/19/20.
//

import Foundation

typealias ItemWithValue = (item: FreeMarketItem, value: Int)

public class GameController {
  var playerItemInventory: [ItemWithValue] = []
  var marketPlace: [ItemWithValue] = [ItemWithValue]()
  var playerCashInventory: Int = 0
  var playerDebtInventory: Int = 0
  private var marketPlaceItems: [FreeMarketItem]
  private var minMarketPlaceItems: Int = 0
  private var maxMarketPlaceItems: Int?
  
  init (gameWithItems items: [FreeMarketItem],
        startingCash cash: Int = 0,
        startingDebt debt: Int = 0,
        minMarketPlaceItems minItems: Int = 0,
        maxMarketPlaceItems maxItems: Int? = nil) {
    playerCashInventory = cash
    playerDebtInventory = debt
    marketPlaceItems = items
    minMarketPlaceItems = minItems
    maxMarketPlaceItems = maxItems ?? items.count
    marketPlace = setMarketPlace(marketPlaceItems: items, minMarketPlaceItems: minItems, maxMarketPlaceItems: maxItems)
  }
  
  func resetMarketPlace () {
    marketPlace = setMarketPlace(marketPlaceItems: marketPlaceItems, minMarketPlaceItems: minMarketPlaceItems, maxMarketPlaceItems: maxMarketPlaceItems)
  }
  
  func setMarketPlace (marketPlaceItems items : [FreeMarketItem],
                       minMarketPlaceItems minItems : Int,
                       maxMarketPlaceItems maxItems : Int? = nil) -> [ItemWithValue]{
    let numItems = Int.random(in: minItems..<(maxItems ?? items.count))
    var market: [ItemWithValue] = [ItemWithValue]()
    for item in items.shuffled()[0..<numItems] {
      market.append(
        (item, item.determineMarketValue()
        )
      )
    }
    return market.sorted(by: {$0.item.name < $1.item.name})
  }
  
}
