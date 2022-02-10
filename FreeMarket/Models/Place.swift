//
//  Place.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/25/20.
//

import Foundation

struct Place: Equatable, Hashable {
  var id: UUID = UUID()
  var name: String
  var image: String = ""

}

extension Place{
  static func demoPlace () -> Place {
    return Place(name:"Demo Place")
  }
}
