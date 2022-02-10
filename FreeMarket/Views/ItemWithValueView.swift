//
//  ItemView.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/23/20.
//

import SwiftUI


struct MarketCellView: View {
  @EnvironmentObject var playerStats: Player
  let itemWithValue: ItemWithValue
  var item: FreeMarketItem {itemWithValue.item}
  var value: Int {itemWithValue.value}
  @State var buySheetIsPresented: Bool = false
  let currencyFormatter:NumberFormatter = { () -> NumberFormatter in
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    return formatter
    
  }()
  
  var body: some View {
    ZStack {
      VStack (alignment: .leading) {
        HStack(){
          Image(item.icon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height:20)
            .padding(5)
            .foregroundColor(.black)
            .background(Circle().fill(Color.white))
          Text(item.name)
            .font(.system(.title2, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.white)
        }
//        .foregroundColor(.white)
        VStack() {
          HStack(alignment:.center) {
            VStack(alignment:.leading) {
            Button(action: {
              buySheetIsPresented.toggle()
            }){
              HStack {
                Image(systemName: "briefcase")
                Text("xx units @ $xx,xxx")
                  .font(.caption2)
                  .fontWeight(.semibold)
  //                .background(Color.white)
                
              }
              .padding(6)
              .background(
                RoundedRectangle(cornerRadius: 3)
                  .foregroundColor(Color.white)
              )
            }
            .foregroundColor(Color(UIColor.darkGray))
            }
            Spacer()
            Button(action: {
              buySheetIsPresented.toggle()
            }){
              Text("$\(value)")
                .fontWeight(.semibold)
                .padding(3)
//                .background(Color.white)
                .background(
                  RoundedRectangle(cornerRadius: 3)
                    .foregroundColor(Color.white)
                  
                )
            }
            
          }
          .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        }
      }
    }.popover(isPresented: $buySheetIsPresented, content: {
      BuyView(isPresented: $buySheetIsPresented, itemWithValue: itemWithValue)
        .environmentObject(playerStats)
    })
    .padding(10)
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(Color(red: item.color[0]/256, green: item.color[1]/256, blue:item.color[2]/256))
      
    )
  }
}

struct ItemView_Previews: PreviewProvider {
  static var previews: some View {
    MarketCellView(itemWithValue: ItemWithValue( FreeMarketItem.demoItems.randomElement()!, Int.random(in: 1...30000)))
      .previewLayout(.sizeThatFits)
  }
}
