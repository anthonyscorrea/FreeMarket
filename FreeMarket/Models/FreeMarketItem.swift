//
//  FreeMarketItem.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/10/20.
//

import Foundation
import SwiftUI

protocol Item {
  var id: UUID {get}
  var name: String {get}
}

public class FreeMarketItem: Item, Hashable {
  let id = UUID()
  public let name: String
  public let minPrice: Int
  public let maxPrice: Int
  public let priceTypes: [PriceType]
  let color: [Double]
  var becomesExpensive: Bool {
      self.becameExpensiveText != nil
    }
  var becomesCheap: Bool {
    self.becameCheapText != nil
  }
  var becameExpensiveText: [String]? = nil
  var becameCheapText: [String]? = nil
  var icon: String = "pill"
  
  init(
    name: String,
    icon: String = "pill",
    minPrice: Int,
    maxPrice: Int,
    color: [Double] = [210, 208, 186],
    becameExpensiveText: [String]? = nil,
    becameCheapText: [String]? = nil
  ) {
    self.name = name
    self.icon = icon
    self.minPrice = minPrice
    self.maxPrice = maxPrice
    self.color = color
    self.becameExpensiveText = becameExpensiveText
    self.becameCheapText = becameCheapText
    var priceTypes: [PriceType] = [.normal]
    if becameExpensiveText != nil {priceTypes.append(.expensive)}
    if becameCheapText != nil {priceTypes.append(.cheap)}
    self.priceTypes = priceTypes
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  public static func == (lhs: FreeMarketItem, rhs: FreeMarketItem ) -> Bool {
    return lhs.id == rhs.id
  }
  
}

extension FreeMarketItem {
  
  //Convience intializer if item price never changes
  convenience init(name: String, price: Int){
    self.init(
      name: name,
      minPrice: price,
      maxPrice: price
    )
  }
  
}
