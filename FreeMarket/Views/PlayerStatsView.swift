//
//  ItemView.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/23/20.
//

import SwiftUI

struct StatsRow: ViewModifier {
  
  let font = Font.system(.title3).weight(.bold)
  
  func body(content: Content) -> some View {
    content
      .font(font)
//      .frame(maxWidth: .infinity)
  }
}

struct PlayerStatsView: View {
  @EnvironmentObject var playerStats: Player
  var body: some View {
    
    HStack {
      VStack(alignment: .trailing) {
        HStack {
          Group {
            Text("\(formatCurrency(number:playerStats.cash))")
              .modifier(StatsRow())
            Image(systemName: "dollarsign.circle.fill")
              .modifier(StatsRow())
            //            .resizable()
            //            .scaledToFit()
          }
          .foregroundColor(.green)
        }
        HStack {
          Group {
            Text("-\(formatCurrency(number: playerStats.debt))")
              .modifier(StatsRow())
            Image(systemName: "creditcard.circle.fill")
              .modifier(StatsRow())
          }
          .foregroundColor(.red)
        }
      }
      VStack(alignment: .leading){
        HStack {
          Image(systemName: "heart.circle.fill")
            .modifier(StatsRow())
          //          .resizable()
          //          .scaledToFit()
          Text("\(playerStats.health)/\(100)")
            .modifier(StatsRow())
        }
        .foregroundColor(.blue)
        HStack {
          Image(systemName: "archivebox.circle.fill")
            .modifier(StatsRow())
          Text("\(playerStats.availableInventory)/\(playerStats.maxInventory)")
            .modifier(StatsRow())
        }
        .foregroundColor(Color(UIColor.brown))
      }
      }
    .frame(maxWidth: .infinity)
    .padding(.vertical,5)
    .background(Color(.secondarySystemBackground))
      .cornerRadius(5)
    
    }
}

struct PlayerStatsView_preview: PreviewProvider {
  static var previews: some View {
    PlayerStatsView()
      .previewLayout(.sizeThatFits)
      .environmentObject(Player.demoPlayer)
  }
}
