//
//  CurrencyFormatter.swift
//  DopeWars
//
//  Created by Anthony Correa on 11/5/20.
//

import Foundation

func formatCurrency(number: Int) -> String {
  let formatter = NumberFormatter()
  formatter.usesGroupingSeparator = true
  formatter.numberStyle = .currency
  formatter.maximumFractionDigits = 0
//  formatter
  return formatter.string(from: NSNumber(value: number))!
}

