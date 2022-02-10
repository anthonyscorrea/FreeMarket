//
//  ItemView.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/23/20.
//

import SwiftUI


struct MarketCellView: View {
  @EnvironmentObject var playerStats: Player
//  let itemWithValue: valuedFreeMarketItem
  var item: FreeMarketItem
  var marketEntry: MarketEntry
  var price: Int { marketEntry.price }
  @State var transactSheetIsPresented: Bool = false
  @State var transactionType: TransactionType = .buy
  
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
          if marketEntry.priceType == PriceType.normal{
          Text(item.name)
            .font(.system(.body, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.white)
          } else {
            Text(item.name)
              .font(.system(.body, design: .rounded))
              .fontWeight(.bold)
              .foregroundColor(.yellow)
          }
        }
        //        .foregroundColor(.white)
        Spacer()
        HStack(alignment:.center) {

          if ((playerStats.itemInventory[item]?.totalQuantity ?? 0) > 0) {
            InventoryBadgeButton(marketEntry: marketEntry, inventoryRecord: playerStats.itemInventory[item]!) {
              transactionType = .sell
              transactSheetIsPresented.toggle()
            }
            .environmentObject(playerStats)
            .sheet(isPresented: $transactSheetIsPresented, content: {
              TransactView(transactionType: $transactionType, isPresented: $transactSheetIsPresented, item: item, marketEntry: marketEntry)
                .environmentObject(playerStats)
            })
          }
          
          Spacer()
          PriceBadgeButton(marketEntry: marketEntry){
            transactionType = .buy
            transactSheetIsPresented.toggle()
          }
          .environmentObject(playerStats)
          .sheet(isPresented: $transactSheetIsPresented, content: {
            TransactView(transactionType: $transactionType, isPresented: $transactSheetIsPresented, item: item, marketEntry: marketEntry)
              .environmentObject(playerStats)
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

struct ItemView_Previews: PreviewProvider {
  static var item = FreeMarketItem.demoItem
  static var previews: some View {
    Text("")
//    MarketCellView(item: item, price: MarketPlace.determinePrice(item))
//      .previewLayout(.sizeThatFits)
//      .environmentObject(Player())
  }
}
