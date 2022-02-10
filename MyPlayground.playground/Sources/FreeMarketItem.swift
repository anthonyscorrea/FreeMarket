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

public class FreeMarketItem: Item {
  let id = UUID()
  let name: String
  let minPrice: Int
  let maxPrice: Int
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
  
  func determineMarketValue () -> Int {
    Int.random(in: minPrice...maxPrice)
  }
  
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
