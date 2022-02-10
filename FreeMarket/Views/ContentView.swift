//
//  ContentView.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/23/20.
//

import SwiftUI

struct SectionHeaderTextModifier: ViewModifier {
  
  let font = Font.system(.title3, design: .rounded).weight(.semibold)
  
  func body(content: Content) -> some View {
        content
          .font(font)
          .padding(.leading)
    }
}

struct ContentView: View {
  @State var marketPlace: MarketPlace
  @EnvironmentObject var playerStats: Player
  @State var places: [Place] = Place.demoPlaces
  @State var place: Place = Place.demoPlaces.randomElement()!
  @State var test = 0
  @State var day = 1
  @State var marketIsShown: Bool = true
  @State var showOnlyOwned: Bool = false
  
  var body: some View {
    ScrollView (.vertical) {
      VStack(alignment: .leading){
        HStack{
          PlayerStatsView()
            .padding(.horizontal)
        }
        
        HStack () {
          VStack(alignment: .trailing){
            Text("Day".uppercased())
              .font(.caption2)
              .foregroundColor(Color(UIColor.systemGray))
            //              .frame(maxWidth: .infinity, alignment:.leading)
            //              Spacer()
            Text("\(day)")
              .font(.system(.title, design: .rounded))
              .fontWeight(.bold)
            //              .frame(maxWidth: .infinity, alignment:.trailing)
          }
          
          if marketIsShown {
            WelcomeToView(place: place)
              .frame(maxWidth: .infinity, alignment: .leading)
          } else {
            WelcomeToView(place: place).hidden()
          }
        }
        .padding([.leading, .top])
        //        Divider()
        //          .padding(.leading)
//
        if marketPlace.hasExceptionalPricingCurrently {
          Divider()
            .padding(.leading)
          Section(header:
                    HStack () {
                      Text("News")
                        .modifier(SectionHeaderTextModifier())
                    }){
          NewsGridView(marketPlace: marketPlace)
                    }
        }
        
        Divider()
          .padding(.leading)
        Section(header:
                  HStack () {
                    Text("Market")
                      .modifier(SectionHeaderTextModifier())
                  }
        ){
          if marketIsShown {
            MarketGridView(marketPlace: marketPlace)

          }
          if !marketIsShown {
            MarketGridView(marketPlace: marketPlace)
              .hidden()
          }
        }
        //        .padding(.leading)
        Divider()
          .padding(.leading)
        Section(header:
                  HStack () {
                    Text("Travel")
                      .modifier(SectionHeaderTextModifier())
                    
                  }
        ) {
          
          ScrollView(.horizontal){
            LazyHGrid(rows: Array.init(repeating: GridItem(.flexible(), spacing: 5), count: 1)){
              ForEach(places, id: \.self){place in
                if self.place != place {
                  TravelCellView(currentPlace: self.$place, thisPlace: place)
                }
              }
              TravelCellView(currentPlace: self.$place, thisPlace: Place(name: "Airport"))
            }.padding([.leading, .trailing])
          }
          .frame(height:60)
        }
        if true {
          Divider()
            .padding(.leading)
          Section(header:
                    HStack {
                      Text("Inventory")
                        .modifier(SectionHeaderTextModifier())
                      Spacer(minLength: 100)
                        .padding(.trailing)
                    }
          ){
            InventoryGridView(marketPlace: marketPlace)
            
          }
        }
        Spacer()
        
        
      }
      .onChange(of: place, perform: { value in
        marketPlace.advance()
        print(marketPlace.scheduledEntries)
        withAnimation{self.marketIsShown.toggle()}
        day += 1
        withAnimation{self.marketIsShown.toggle()}
      })
    }
//    .padding(.leading)
  }
  
}

struct ContentView_Previews: PreviewProvider {
//  @EnvironmentObject var playerStats: PlayerStats
//  static let playerStats = PlayerStats.demoPlayerStats()
  
  static var previews: some View {
    Group{
      ContentView(marketPlace: MarketPlace.demoMarketPlace)
        .environmentObject(Player.demoPlayer)
      .environment(\.sizeCategory, .extraSmall)
    ContentView(marketPlace: MarketPlace.demoMarketPlace)
      .environmentObject(Player.demoPlayer)
      .environment(\.sizeCategory, .extraExtraExtraLarge)
    ContentView(marketPlace: MarketPlace.demoMarketPlace)
        .environmentObject(Player.demoPlayer)
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
  }
}
}

struct NewsGridView: View {
  @ObservedObject var marketPlace: MarketPlace
  var body: some View {

//    ScrollView(.horizontal){
//      LazyHGrid(rows: Array.init(repeating: GridItem(.flexible(), spacing: 5), count: 1)){
    VStack(alignment:.leading){
        ForEach(marketPlace.items, id: \.self){item in
          if marketPlace.current[item]!.available && marketPlace.current[item]!.priceType != .normal {
          switch marketPlace.current[item]!.priceType {
          case .cheap:
            NewsViewCell(text: "\(item.becameCheapText!.randomElement()!)")
          case .expensive:
            NewsViewCell(text: "\(item.becameExpensiveText!.randomElement()!)")
          case .normal:
            EmptyView()
          }
        }
        }
        .padding(.horizontal)
      }
      .transition(.slide)
//      .frame(height: 100)
    }
//  }
}

struct MarketGridView: View {
  @EnvironmentObject var playerStats: Player
  @ObservedObject var marketPlace: MarketPlace
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false){
      LazyHGrid(rows: Array.init(repeating: GridItem(.flexible(), spacing: 15), count: 2)){
        ForEach(marketPlace.items, id: \.self){item in
          if marketPlace.current[item]!.available {
            MarketCellView(item:item, marketEntry: marketPlace.current[item]!)
              .environmentObject(playerStats)
          }
          
        }
        .layoutPriority(1)
      }
      .padding([.leading, .trailing])
    }
    .frame(height: 200)
//    .frame(maxHeight: .infinity)
//    .transition(.slide)
  }
}

struct InventoryGridView: View {
  @EnvironmentObject var playerStats: Player
  @ObservedObject var marketPlace: MarketPlace
  var body: some View {
    ScrollView(.horizontal){
      LazyHGrid(rows: Array.init(repeating: GridItem(.flexible(), spacing: 10), count: 2)){
        ForEach(marketPlace.items, id: \.self){item in
          if (playerStats.inInventory(item) > 0) {
            MarketCellView(item:item, marketEntry: marketPlace.current[item]!)
              .environmentObject(playerStats)
          }
          
        }
      }
      .padding([.leading, .trailing])
    }
    .transition(.slide)
    .frame(height: 180)
  }
}

struct WelcomeToView: View {
  var place: Place
  var body: some View {
    HStack {
      Image(place.image)
        .resizable()
        .scaledToFit()
        .padding(.leading)
        .frame(maxHeight:50)
      VStack (alignment: .leading) {
        Text("Welcome to".uppercased())
          .font(Font.system(.caption2))
          .transition(.slide)
          .foregroundColor(.gray)
        Text("\(place.name)")
          .font(Font.system(.title, design: .rounded))
          .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
      }
    }
  }
}
