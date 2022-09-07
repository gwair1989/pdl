//
//  DataFetcherService.swift
//  ViewController. Single Responsibility Principle.
//
//  Created by Алексей Пархоменко on 17/06/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation

protocol DataServiseProtocol {
    func fetchConversion(completion: @escaping (Conversion?) -> Void)
}



class DataFetcherService: DataServiseProtocol {
    
    var networkDataFetcher: DataFetcher
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchConversion(completion: @escaping (Conversion?) -> Void) {
        let urlString = "https://api.exchangerate.host/latest?base=USD"
        networkDataFetcher.fetchGenericJSONData(urlString: urlString, response: completion)
    }
    
}


class MockDataFetcherService: DataServiseProtocol {
    
    let data: Conversion = Conversion(rates: ["UAH": 29.835471, "RUB": 57.072392, "CHF": 0.989471, "PLN": 4.399461, "CZK": 23.529844, "CNY": 6.734479, "TRY": 17.223909])

    func fetchConversion(completion: @escaping (Conversion?) -> Void) {
        completion(data)
    }
}
