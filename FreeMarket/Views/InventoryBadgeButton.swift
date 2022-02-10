//
//  InventoryBadgeButton.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/31/20.
//

import SwiftUI

struct InventoryBadgeButton: View {
  @EnvironmentObject var playerStats: Player
  var marketEntry: MarketEntry
  var inventoryRecord: InventoryRecord
  var action: () -> Void
  var body: some View {
    Button(action: {
      if marketEntry.available {
        action()
      }
    }){
      HStack {
        Image(systemName: "archivebox.circle")
        Text("\(inventoryRecord.totalQuantity) @ $\(inventoryRecord.basis)")
          .font(.caption2)
          .fontWeight(.semibold)
          .lineLimit(2)
        //                .background(Color.white)
        
      }
      .padding(6)
      .background(
        RoundedRectangle(cornerRadius: 5)
          .foregroundColor(Color(.secondarySystemBackground))
      )
    }
    .foregroundColor(Color(UIColor.brown))
  }
}

struct InventoryBadgeButton_Previews: PreviewProvider {
    static var previews: some View {
//        InventoryBadgeButton()
      Text("")
    }
}
