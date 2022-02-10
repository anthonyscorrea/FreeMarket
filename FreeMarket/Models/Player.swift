//
//  GameController.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/19/20.
//

import Foundation



public struct InventoryRecord {
  public var quantity: Int {
    transactions.reduce(0) { (result, transaction) -> Int in
      result + transaction.quantity
    }
  }
  public var basis: Int {
    if totalQuantity != 0 {
      return totalValue / totalQuantity}
    else {return 0}
  }
  
  public var totalValue: Int {
    transactions.reduce(0) { (result, transaction) -> Int in
      result + (transaction.price * transaction.quantity)
    }
  }
  
  public var totalQuantity: Int {
    transactions.reduce(0) { (result, transaction) -> Int in
      result + transaction.quantity
    }
  }

  public var transactions: [(quantity: Int, price: Int)]
  
  public init(quantity: Int, atPrice price: Int) {
    self.transactions = [(quantity, price)]
  }
  
  public mutating func transact (addQuantity quantity: Int, atPrice price: Int) {
    self.transactions.append((quantity, price))
  }
  
  public mutating func transact (removeQuantity quantity: Int) {
    self.transactions.append((-quantity, basis))
  }
  
}


public class Player: ObservableObject {
  @Published public var itemInventory = Dictionary<FreeMarketItem, InventoryRecord>()
  @Published var maxInventory: Int
  @Published public var cash: Int
  @Published var debt: Int
  @Published var health: Int
  
//  public var ownedItemsWithValue: [valuedFreeMarketItem] {
//    itemInventory.reduce(into: []) { (result, arg1) in
//      let (key, value) = arg1
//      result.append(valuedFreeMarketItem(key, value.basis))
//    }
//  }
  
  public var inventoryUsed: Int {
    itemInventory.reduce(0) { (result, keyvalue) -> Int in
      result + keyvalue.1.totalQuantity
    }
  }
  
  public var availableInventory: Int {
    maxInventory - inventoryUsed
  }

  public init (startingCash cash: Int = 0,
               maximumInventorySpace maxInventory: Int = 100,
               startingDebt debt: Int = 0,
               startingHealth health: Int = 100) {
    self.cash = cash
    self.debt = debt
    self.health = health
    self.maxInventory = maxInventory
  }
    
  public func buy (_ item: FreeMarketItem, quantity: Int, atPrice price: Int) {
    cash -= price * quantity
    if itemInventory[item] != nil {
      self.itemInventory[item]?.transact(addQuantity: quantity, atPrice: price)
    } else {
      itemInventory[item] = InventoryRecord(quantity: quantity, atPrice: price)
    }
    
  }
  
  public func sell (_ item: FreeMarketItem, quantity: Int, atPrice price: Int) {
    cash += price * quantity
    if itemInventory[item] != nil {
      self.itemInventory[item]?.transact(removeQuantity: quantity)
    }  else {
        itemInventory[item] = InventoryRecord(quantity: quantity, atPrice: price)
      }
  }
  
  public func canBuy(_ item: FreeMarketItem, atPrice price: Int) -> Bool {
    return (inventoryUsed != maxInventory && maxAfford(item, atPrice: price) >= 1) ? true : false
  }
  
  public func canSell(_ item: FreeMarketItem, atPrice price: Int) -> Bool {
    (inInventory(item) > 0) ? true : false
  }
  
  public func maxAfford(_ item: FreeMarketItem, atPrice price: Int) -> Int {
    Int(cash / price)
  }
  
  public func inInventory(_ item: FreeMarketItem) -> Int {
    itemInventory[item]?.totalQuantity ?? 0
  }
  
  public func inventoryValue(_ item: FreeMarketItem) {
    
  }
  
}

