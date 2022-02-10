//
//  TransactionType.swift
//  DopeWars
//
//  Created by Anthony Correa on 10/31/20.
//

import Foundation

public enum TransactionType: String, Equatable, CaseIterable, Identifiable {
  case buy
  case sell
  
  public var id: String {self.rawValue}
}
