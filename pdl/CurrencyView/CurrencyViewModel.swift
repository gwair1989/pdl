//
//  CurrencyViewModel.swift
//  pdl
//
//  Created by Oleksandr Khalypa on 05.09.2022.
//

import Foundation


class CurrencyViewModel: ObservableObject, ProtocolsViewModel {
    
    @Published var currences: [Currency] = []
    
    let dataService: DataServiseProtocol
    
    init(dataService: DataServiseProtocol) {
        self.dataService = dataService
        fetchCurrency()
    }
    
    private func fetchCurrency() {
        dataService.fetchConversion { [weak self] conversion in
            guard let conversion = conversion else { return }
            DispatchQueue.main.async {
                let conversionData = conversion.rates.compactMap({ key, value in
                    return FetchingCurrency(currencyName: key, currencyValue: value)
                })
                self?.getCurrency(conversionData: conversionData)
            }
        } 
    }
    
    
    private func getCountryCode(code: String) -> String {
        var currentCode = code
        currentCode.removeLast()
        let countries: [CountryCode] = NSLocale.isoCountryCodes.map {
            let country = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: $0)
            return CountryCode(country: country, code: $0)
        }
        
        if let countryCode = countries.first(where: { $0.code == currentCode }) {
            let localCode = countryCode.code
            return localCode
        }
        return ""
    }
    
    private func formatDouble(_ value: Double) -> String {
        if value > 0.01 {
            return String(format:"%.2f", value)
        }
        return ""
    }
    
    
    private func getCurrencyFullName(code: String) -> String {
        let enUS = Locale(identifier: "en-US")
        if let currencyFullName = enUS.localizedString(forCurrencyCode: code) {
            return currencyFullName
        }
        return ""
    }
    
    
    private func getCurrency(conversionData: [FetchingCurrency]) {
        
        for fetchCurrency in conversionData {
            let flag = getFlag(from: fetchCurrency.currencyName)
            let currencyName = fetchCurrency.currencyName
            let currencyFullName = getCurrencyFullName(code: fetchCurrency.currencyName)
            let currencyValue  = formatDouble(fetchCurrency.currencyValue)
            
            if !flag.isEmpty && !currencyName.isEmpty && !currencyFullName.isEmpty && !currencyValue.isEmpty {
                currences.append(Currency(flag: flag, currencyName: currencyName, currencyFullName: currencyFullName, currencyValue: currencyValue))
            }
        }
    }
    
    
    private func getFlag(from countryCode: String) -> String {
        let code = getCountryCode(code: countryCode)
        return code
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
    
}
