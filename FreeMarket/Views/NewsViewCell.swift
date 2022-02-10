//
//  NewsViewCell.swift
//  DopeWars
//
//  Created by Anthony Correa on 11/12/20.
//

import SwiftUI

struct NewsViewCell: View {
  var text: String
    var body: some View {
        VStack (alignment: .leading) {
          HStack(alignment: .center){
            Image(systemName: "newspaper")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .padding(5)
              .frame(height:24, alignment: .top)
              .foregroundColor(.white)
              .background(Circle().fill(Color.orange))
            Text(text)
              .multilineTextAlignment(.leading)
              .font(.caption)
//              .lineLimit(3)
              .padding(3)
          }
          .padding(5)

          
        }
        .frame(maxWidth: 250)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)

    }
}

struct NewsViewCell_Previews: PreviewProvider {
  
  static let textArray = [
    "Cops made a big %tde bust! Prices are outrageous!",
    "Addicts are buying %tde at ridiculous prices!",
    "Wouldn't it be funny if everyone suddenly quacked at once?",
    "The Pope was once Jewish, you know",
    "I'll bet you have some really interesting dreams",
    "So I think I'm going to Amsterdam this year",
    "Son, you need a yellow haircut",
    "I think it's wonderful what they're doing with incense these days",
    "I wasn't always a woman, you know",
    "Does your mother know you're a dope dealer?",
    "Are you high on something?",
    "Oh, you must be from California",
    "I used to be a hippie, myself",
    "There's nothing like having lots of money",
    "You look like an aardvark!",
    "I don't believe in Ronald Reagan",
    "Courage!  Bush is a noodle!",
    "Haven't I seen you on TV?",
    "I think hemorrhoid commercials are really neat!",
    "We're winning the war for drugs!",
    "A day without dope is like night",
    "We only use 20% of our brains, so why not burn out the other 80%",
    "I'm soliciting contributions for Zombies for Christ",
    "I'd like to sell you an edible poodle",
    "Winners don't do drugs... unless they do",
    "Kill a cop for Christ!",
    "I am the walrus!",
    "Jesus loves you more than you will know",
    "I feel an unaccountable urge to dye my hair blue",
    "Wasn't Jane Fonda wonderful in Barbarella",
    "Just say No... well, maybe... ok, what the hell!",
    "Would you like a jelly baby?",
    "Drugs can be your friend!"
  ]
    static var previews: some View {
      NewsViewCell(text: textArray.randomElement()!)
    }
}
