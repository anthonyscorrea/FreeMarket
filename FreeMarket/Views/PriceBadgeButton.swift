//
//  PriceBadgeButton.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/31/20.
//

import SwiftUI

struct PriceBadgeButton: View {
  var marketEntry: MarketEntry
  var price: Int {marketEntry.price}
  var action: () -> Void
  var body: some View {
    if (marketEntry.available) {
    Button(action: {
      action()
    }){
      //              Image(systemName: "tag")
      //                .foregroundColor(.white)
      
      Text("$\(price)")
        .fontWeight(.semibold)
        .padding(3)
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        .background(
          RoundedRectangle(cornerRadius: 5)
            .foregroundColor(Color.white)
        )
    }
    } else {
      Text("N/A")
        .fontWeight(.semibold)
        .padding(3)
        .foregroundColor(.gray)
        .background(
          RoundedRectangle(cornerRadius: 5)
            .foregroundColor(Color.white)
        )
    }
}
}

struct PriceBadgeButton_Previews: PreviewProvider {
    static var previews: some View {
      Text("")
//      PriceBadgeButton(price: 100, action: {})
//      PriceBadgeButton(action:{})
    }
}
