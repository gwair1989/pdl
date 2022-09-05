//
//  Currency.swift
//  pdl
//
//

import SwiftUI

struct FetchingCurrency: Identifiable {
    var id = UUID().uuidString
    var currencyName: String
    var currencyValue: Double
}


struct Currency: Identifiable {
    var id = UUID().uuidString
    var flag: String
    var currencyName: String
    var currencyFullName: String
    var currencyValue: String
}
