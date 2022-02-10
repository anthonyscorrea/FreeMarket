//
//  TransactView.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/28/20.
//

import SwiftUI

func determineMax (_ transactionType: TransactionType, player: Player, item: FreeMarketItem, atPrice price: Int) -> Int {
  switch transactionType{
  case .buy:
    return min(player.maxAfford(item, atPrice: price), player.availableInventory)
  case .sell:
    return player.inInventory (item)
  }
}

struct TransactView: View {
  @EnvironmentObject var playerStats: Player
  @Binding var transactionType: TransactionType
  @Binding var isPresented: Bool
//  let itemWithValue: valuedFreeMarketItem
  var item: FreeMarketItem
  var marketEntry: MarketEntry
  var price: Int {marketEntry.price}
  //  @Binding var playerCash: Int
  @State private var quantity: Double = 0
  @State private var maxItems = 0
  @State var alertText = ""
  @State var showAlert = false
  
  var body: some View {
    VStack {
      MarketCellView(item: item, marketEntry: marketEntry)
        .frame(height:100)
        .padding()

        Picker("Picker", selection: $transactionType) {
            Text(TransactionType.buy.rawValue.capitalized).tag(TransactionType.buy)
            Text(TransactionType.sell.rawValue.capitalized).tag(TransactionType.sell)
        }
        .disabled(!playerStats.canBuy(item, atPrice: price) || !playerStats.canSell(item, atPrice: price))
        .onChange(of: transactionType, perform: { value in
                    self.maxItems = determineMax(transactionType, player: playerStats, item: item, atPrice: price)
          self.quantity = Double(determineMax(transactionType, player: playerStats, item: item, atPrice: price))})
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
        .font(.title)
      HStack (alignment: .bottom) {
        Text("\(Int(quantity.rounded()))")
          .font(.title)
        Text("units")
      }

      switch transactionType {
      case .buy:
        Text("\(maxItems) units for \(Int(quantity) * price)")
          .font(.caption2)
          .padding()
      case .sell:
        Text("You have \(maxItems). You can sell them for \(Int(quantity) * price) for a profit of \(Int(quantity) * (price -  playerStats.itemInventory[item]!.basis))")
          .font(.caption2)
          .padding()
      }
      
      if isPresented {
        Slider(value: $quantity, in: 0...Double(maxItems))
          .padding(.horizontal)
      }
      
      Button(action: {
        switch transactionType {
        case .buy :
          playerStats.buy(item, quantity: Int(quantity.rounded()), atPrice: price)
        case .sell :
          playerStats.sell(item, quantity: Int(quantity.rounded()), atPrice: price)
        }
        isPresented.toggle()
      }
      ){
        Text("\(transactionType)".capitalized)
      }
      .padding(.horizontal)
      .padding(.vertical, 5)
      .background(Color(UIColor.systemGray6))
      .cornerRadius(10)
      Spacer()
    }
    .onAppear(perform: {
      if !playerStats.canBuy(item, atPrice: price) && !playerStats.canSell(item, atPrice: price) {
        switch transactionType {
        case .buy:
          alertText = "You can't buy \(item.name)!"
        case .sell:
          alertText = "You can't sell \(item.name)!"
        }
        showAlert = true
      }
      
      if transactionType == .buy && !playerStats.canBuy(item, atPrice: price) && playerStats.canSell(item, atPrice: price){
        
        transactionType = .sell
      }
      
      if transactionType == .sell && !playerStats.canSell(item, atPrice: price) && playerStats.canBuy(item, atPrice: price) {
        transactionType = .buy
      }
      
      self.maxItems = determineMax(transactionType, player: playerStats, item: item, atPrice: price)
      self.quantity = Double(determineMax(transactionType, player: playerStats, item: item, atPrice: price))

    })
    .alert(isPresented: $showAlert){
      Alert(title:Text(alertText), dismissButton: .default(Text("Fine!"), action: {isPresented = false}))
    }
  }
  
}

//struct QuantitySlider: View {
//  @Binding var transactionType: TransactionType
//  @EnvironmentObject var playerStats: Player
//  let itemWithValue: ItemWithValue
//  var item: FreeMarketItem {itemWithValue.item}
//
//  @Binding var quantity: Double
//
//    var maxItems: Int {
//      switch transactionType {
//      case .buy :
//        return min(playerStats.maxAfford(itemWithValue), playerStats.availableInventory)
//      case .sell :
//        return playerStats.itemInventory[item]?.totalQuantity ?? 0
//    }
//    }
//
//  var body: some View {
//
////    Slider(value: $quantity)
//        switch transactionType {
//        case .buy :
//          return Slider(value: $quantity, in: 1...maxItems)
//        case .sell :
//          return Slider(value: $quantity, in: 1...maxItems)
////          return AnyView(Text("Sell"))
//        }
//  }
//}
//    .padding(.horizontal)

struct TransactView_Previews: PreviewProvider {
  //  @EnvironmentObject var playerStats
  static var item = FreeMarketItem.demoItem
  
  
  static var previews: some View {
    Text("")
//    TransactView(transactionType: .constant(TransactionType.sell), isPresented: .constant(true), item: item, price: MarketPlace.determinePrice(item))
//          .environmentObject(Player.demoPlayer)
//          .previewLayout(.sizeThatFits)
//          .environmentObject(Player.demoPlayer)
  }
}
