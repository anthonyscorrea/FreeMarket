//
//  ItemView.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/23/20.
//

import SwiftUI


struct InventoryCellView: View {
  @EnvironmentObject var playerStats: Player
  let itemWithValue: ItemWithValue
  var item: FreeMarketItem {itemWithValue.item}
  var value: Int {itemWithValue.value}
  @State var transactSheetIsPresented: Bool = false
  @State var transactionType: TransactionType = .buy
  let currencyFormatter:NumberFormatter = { () -> NumberFormatter in
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    return formatter
    
  }()
  
  var body: some View {
    ZStack {
      VStack (alignment: .leading) {
        HStack(alignment: .top){
          Image(item.icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height:24)
            .padding(5)
            .foregroundColor(.black)
            .background(Circle().fill(Color.white))
          Text(item.name)
            .font(.system(.body, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.white)
        }
        //        .foregroundColor(.white)
        Spacer()
        HStack(alignment:.center) {

          if ((playerStats.itemInventory[item]?.totalQuantity ?? 0) > 0) {
            InventoryBadgeButton(inventoryRecord: playerStats.itemInventory[item]!) {
              transactionType = .sell
              transactSheetIsPresented.toggle()
            }
            .sheet(isPresented: $transactSheetIsPresented, content: {
              TransactView(transactionType: $transactionType, isPresented: $transactSheetIsPresented, itemWithValue: itemWithValue)
            })
          }
          
          Spacer()
          PriceBadgeButton(price: value){
            transactionType = .buy
            transactSheetIsPresented.toggle()
          }
          .sheet(isPresented: $transactSheetIsPresented, content: {
            TransactView(transactionType: $transactionType, isPresented: $transactSheetIsPresented, itemWithValue: itemWithValue)
          })
          
        }
      }
    }
//  .environmentObject(playerStats)
    .padding(10)
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(Color(red: item.color[0]/256, green: item.color[1]/256, blue:item.color[2]/256))
      
    )
  }
}

struct InventoryBadgeButton: View {
  @EnvironmentObject var playerStats: Player
  var inventoryRecord: InventoryRecord
  var action: () -> Void
  var body: some View {
    Button(action: {
      action()
    }){
      HStack {
        Image(systemName: "briefcase")
        Text("\(inventoryRecord.totalQuantity) units @ $\(inventoryRecord.basis)")
          .font(.caption2)
          .fontWeight(.semibold)
        //                .background(Color.white)
        
      }
      .padding(6)
      .background(
        RoundedRectangle(cornerRadius: 5)
          .foregroundColor(Color.white)
      )
    }
    .foregroundColor(Color(UIColor.darkGray))
  }
}

struct PriceBadgeButton: View {
  var price: Int
  var action: () -> Void
  var body: some View {
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
  }
}

struct ItemView_Previews: PreviewProvider {
  static var previews: some View {
    MarketCellView(itemWithValue: ItemWithValue( FreeMarketItem.demoItems.randomElement()!, Int.random(in: 1...30000)))
      .previewLayout(.sizeThatFits)
      .environmentObject(Player())
  }
}
