//
//  demoItems.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/10/20.
//
import SwiftUI

let colors = [
  [229.0, 85.0, 155.0],
  [209.0, 121.0, 83.0],
  [191.0, 147.0, 70.0],
  [81.0,158.0,55.0],
  [42.0,127.0,104.0],
  [94.0,28.0,30.0],
  [209.0,21.0,18.0],
  [124.0,124.0,77.0],
  [244.0,85.0,0.0],
  [74.0,91.0,5.0]
]

public extension FreeMarketItem {
  static let demoItem: FreeMarketItem = demoItems.randomElement()!
  
  static let demoItems: [FreeMarketItem] = [
    FreeMarketItem(name:"Acid",
                   icon: "acid",
                   minPrice: 1000,
                   maxPrice: 4400,
//                   color: [229, 193, 189],
                   color: colors[2],
                   becameCheapText:["The market is flooded with cheap home-made acid!"]),
    
    FreeMarketItem(name:"Cocaine",
                   icon: "cocaine",
                   minPrice: 15000,
                   maxPrice: 29000,
//                   color: [182, 190, 1156],
                   color: colors[5],
                   becameExpensiveText: ["Cops made a big cocaine bust! Prices are outrageous!"]),
    FreeMarketItem(name:"Hashish",
                   icon: "hashish",
                   minPrice: 480,
                   maxPrice: 1280,
//                   color: [123, 158, 135],
                   color: colors[7],
                   becameCheapText:["The Marrakesh Express has arrived!"]),
    FreeMarketItem(name:"Heroin",
                   icon: "heroin",
                   minPrice: 5500,
                   maxPrice: 13000,
//                   color: [95, 81, 63],
                   color: colors[9],
                   becameExpensiveText: ["Cops made a big heroin bust! Prices are outrageous!"]),
    
    FreeMarketItem(name:"Ludes",
                   icon: "pill",
                   minPrice: 11,
                   maxPrice: 60,
//                   color: [235, 227, 137],
                   color: colors[1],
                   becameCheapText:["Rival dealers raided a pharmacy and are selling cheap ludes!"]),
    
    FreeMarketItem(name:"MDA",
                   icon:"mdma",
                   minPrice: 1500,
                   maxPrice: 4400,
//                   color: [246, 233, 0]
                   color: colors[0]
    ),
    
    FreeMarketItem(name:"Opium",
                   icon: "opium",
                   minPrice: 540,
                   maxPrice: 1250,
//                   color: [94, 116, 127],
                   color: colors[2],
                   becameExpensiveText: ["Cops made a big opium bust! Prices are outrageous!"]),
    
    FreeMarketItem(name:"PCP",
                   icon: "pcp",
                   minPrice: 1000,
                   maxPrice: 2500,
                   color: colors[3]
//                   color: [235, 227, 137]
    ),
    
    FreeMarketItem(name:"Peyote",
                   icon: "peyote",
                   minPrice: 220,
                   maxPrice: 700,
                   color: colors[3]
    ),
    
    FreeMarketItem(name:"Shrooms",
                   icon: "shrooms",
                   minPrice: 630,
                   maxPrice: 1300,
                   color: colors[8]
    ),
    
    FreeMarketItem(name:"Speed",
                   minPrice: 90,
                   maxPrice: 250,
                   color: colors[8],
                   becameExpensiveText: ["Cops made a big speed bust! Prices are outrageous!"]),
    
    FreeMarketItem(name:"Weed",
                   icon: "marijuana",
                   minPrice: 315,
                   maxPrice: 890,
//                   color: [29, 91, 14],
                   color: colors[3],
                   becameCheapText:["Columbian freighter dusted the Coast Guard!",
                                        "Weed prices have bottomed out!"])
  ]
}
