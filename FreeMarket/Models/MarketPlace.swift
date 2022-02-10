//
//  GameController.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/19/20.
//

import Foundation

public enum PriceType: String, CaseIterable {
  case normal
  case expensive
  case cheap
}

public enum MarketInfo: String, CaseIterable {
  case price
  case pricetype
  case availability
  case entry
}

public struct MarketEntry {
  public let price: Int
  public let priceType: PriceType
  public let available: Bool
}

let defaultExceptionalPriceFactor = 5.0

public class MarketPlace: ObservableObject {
  @Published public var market = [(item:FreeMarketItem, price:Int)]()
  public let items: [FreeMarketItem]
  private var minDailyAvailableItems: Int
  private var maxDailyAvailableItems: Int
  private var scheduleDays: Int = 5
  @Published public var scheduledEntries = [[MarketEntry]]()
  public var probabilityOfExceptionalPrice: Double = 0.25
  public var exceptionalPriceFactor: Double = 5.0
  public var current: Dictionary<FreeMarketItem, MarketEntry> {
    items.enumerated().reduce(into: [FreeMarketItem:MarketEntry]()) {
      let (itemIndex, item) = $1
      $0[item] = scheduledEntries[0][itemIndex]
    }
  }
  
  init (gameWithItems items: [FreeMarketItem],
        minMarketPlaceItems minItems: Int = 0,
        maxMarketPlaceItems maxItems: Int? = nil) {
    self.items = items
    self.minDailyAvailableItems = minItems
    self.maxDailyAvailableItems = maxItems ?? items.count
    setSchedule()
  }
  
  private func setSchedule (){
    for _ in 1...scheduleDays {
      var priceTypesOnDay = [PriceType]()
      var pricesOnDay = [Int]()
      var entriesOnDay = [MarketEntry]()
      let availabilitiesOnDay = determineDailyAvailability()
      for (itemIndex, item) in items.enumerated() {
        let priceType = determineIsExceptionallyPriced(item)
        let price = MarketPlace.determinePrice(item, priceType: priceType, exceptionalPriceFactor: exceptionalPriceFactor)
        let entry = MarketEntry(price: price, priceType: priceType, available: availabilitiesOnDay[itemIndex])
        priceTypesOnDay.append(priceType)
        pricesOnDay.append(price)
        entriesOnDay.append(entry)
      }
      
//      self.scheduledPriceType.append(priceTypesOnDay)
//      self.scheduledPrices.append(pricesOnDay)
//      self.scheduledAvailability.append(availabilitiesOnDay)
      self.scheduledEntries.append(entriesOnDay)
    }
  }
  
  private func determineDailyAvailability () -> [Bool] {
    let num = Int.random(in: minDailyAvailableItems...maxDailyAvailableItems)
    var resultIndexes = Set<Int>()
    while resultIndexes.count < num {
      resultIndexes.insert(Int.random(in: 0...items.count))
    }
    var result = [Bool]()
    for index in 0...items.count {
      result.append(resultIndexes.contains(index))
    }
    return result
  }
  
  private func determineIsExceptionallyPriced (_ item: FreeMarketItem) -> PriceType {
    var priceTypes = item.priceTypes
    var toBeExceptionallyPriced: Bool = false
    if priceTypes.contains(.cheap) || priceTypes.contains(.expensive){
      toBeExceptionallyPriced = (Int.random(in: 0...100) < Int(probabilityOfExceptionalPrice * 100))
    }
  if toBeExceptionallyPriced {
    priceTypes.removeFirst()
  } else {
    return .normal}
    
    return priceTypes.randomElement()!

  }
  
  public func currentPrice (of item: FreeMarketItem) -> Int {
    self.current[item]!.price
  }

//  public func currentAvailability (of item: FreeMarketItem) -> Bool {
//    let index = items.firstIndex(of: item)
//    return self.scheduledAvailability[0][index!]
//  }
  static public func determinePrice (_ item : FreeMarketItem, priceType: PriceType = .normal, exceptionalPriceFactor: Double = 5.0) -> Int {
    var minPrice = item.minPrice
    var maxPrice = item.maxPrice
    switch priceType {
    case .cheap :
      minPrice = Int(Double(item.minPrice) / exceptionalPriceFactor)
      maxPrice = Int(Double(item.maxPrice) / exceptionalPriceFactor)
    case .expensive :
      minPrice = item.minPrice * Int(exceptionalPriceFactor)
      maxPrice = item.maxPrice * Int(exceptionalPriceFactor)
    case .normal :
      minPrice = item.minPrice
      maxPrice = item.maxPrice
    }
    return Int.random(in: minPrice...maxPrice)
  }
  
  public var hasExceptionalPricingCurrently:Bool {
    return scheduledEntries[0].reduce(0) {
      $0 + (($1.priceType != .normal && $1.available) ? 1 : 0)
    } > 0
  }
  
  public func advance () {
//    scheduledPrices.removeFirst()
//    scheduledPrices.append(items.map{determinePrice($0)})
//    scheduledAvailability.removeFirst()
//    scheduledAvailability.append(determineDailyAvailability())
    scheduledEntries.removeFirst()
    let availabilitiesForDay = determineDailyAvailability()
    var entries = [MarketEntry]()
    for (itemIndex, item) in items.enumerated() {
      let priceType = determineIsExceptionallyPriced(item)
      let price = MarketPlace.determinePrice(item, priceType: priceType, exceptionalPriceFactor: exceptionalPriceFactor)
    entries.append(MarketEntry(price: price, priceType: priceType, available: availabilitiesForDay[itemIndex]))
  }
    scheduledEntries.append(entries)
}
}

