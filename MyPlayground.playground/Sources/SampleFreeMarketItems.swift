//
//  SampleFreeMarketItems.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/10/20.
//
import SwiftUI

let SampleFreeMarketItems: [FreeMarketItem] = [
    FreeMarketItem(name:"Acid",
                   icon: "acid",
                   minPrice: 1000,
                   maxPrice: 4400,
                   color: [229, 193, 189],
                   becameExpensiveText:["The market is flooded with cheap home-made acid!"]),
    
    FreeMarketItem(name:"Cocaine",
                   icon: "cocaine",
                   minPrice: 15000,
                   maxPrice: 29000,
                   color: [182, 190, 1156],
                   becameCheapText: [""]),
    FreeMarketItem(name:"Hashish",
                   icon: "hashish",
                   minPrice: 480,
                   maxPrice: 1280,
                   color: [123, 158, 135],
                   becameExpensiveText:["The Marrakesh Express has arrived!"]),
    FreeMarketItem(name:"Heroin",
                   icon: "heroin",
                   minPrice: 5500,
                   maxPrice: 13000,
                   color: [95, 81, 63],
                   becameCheapText: [""]),
    
    FreeMarketItem(name:"Ludes",
                   icon: "pill",
                   minPrice: 11,
                   maxPrice: 60,
                   color: [235, 227, 137],
                   becameExpensiveText:["Rival FreeMarketItem dealers raided a pharmacy and are selling cheap ludes!"]),
    
    FreeMarketItem(name:"MDA",
                   icon:"mdma",
                   minPrice: 1500,
                   maxPrice: 4400,
                   color: [246, 233, 0]
                   ),
    
    FreeMarketItem(name:"Opium",
                   icon: "opium",
                   minPrice: 540,
                   maxPrice: 1250,
                   color: [94, 116, 127],
                   becameCheapText: [""]),
    
    FreeMarketItem(name:"PCP",
                   icon: "pcp",
                   minPrice: 1000,
                   maxPrice: 2500,
                   color: [235, 227, 137]),
    
    FreeMarketItem(name:"Peyote",
                   icon: "peyote",
                   minPrice: 220,
                   maxPrice: 700
                   ),
    
    FreeMarketItem(name:"Shrooms",
                   icon: "shrooms",
                   minPrice: 630,
                   maxPrice: 1300
                   ),
    
    FreeMarketItem(name:"Speed",
                   minPrice: 90,
                   maxPrice: 250,
                   becameCheapText: [""]),
    
    FreeMarketItem(name:"Weed",
                   icon: "marijuana",
                   minPrice: 315,
                   maxPrice: 890,
                   color: [29, 91, 14],
                   becameExpensiveText:["Columbian freighter dusted the Coast Guard!",
                                        "Weed prices have bottomed out!"])
]
