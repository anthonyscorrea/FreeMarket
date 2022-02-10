//
//  ItemView.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/23/20.
//

import SwiftUI



struct TravelCellView: View {
  @Binding var currentPlace: Place
  var thisPlace: Place
  
  var body: some View {
    Button(action:{currentPlace = thisPlace}){
    ZStack {
      VStack (alignment: .leading) {
        HStack(alignment: .center){
          Image(thisPlace.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height:40)
            .background(Color.white)
            .cornerRadius(5)
          Text(thisPlace.name)
            .font(.system(.headline, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(.primary)
        }
//        Text("travel from \(currentPlace.name)")
        VStack() {
          
        }
      }
    }
    .padding(.vertical, 5)
    .padding(.horizontal, 5)
    .background(Color(UIColor.systemGray5))
    .cornerRadius(10)
  }
  }
}

struct TravelCellView_Previews: PreviewProvider {
  static var previews: some View {
    TravelCellView(currentPlace: .constant(Place.demoPlaces.randomElement()!), thisPlace: Place.demoPlaces.randomElement()!)
      .previewLayout(.sizeThatFits)
  }
}
