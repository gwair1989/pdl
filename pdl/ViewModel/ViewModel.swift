//
//  ViewModel.swift
//  pdl
//
//

import Foundation
import SwiftUI


class ViewModel: ObservableObject  {
    
    @Published var currences: [Currency] = []
    @Published var reminders: [Reminder] = []
    
    private let remindersKeyName = "Reminders"
    
    init() {
        fetch()
        loadReminders()
        removeOldReminder()
    }
    
    private func fetch() {
        let urlString = "https://api.exchangerate.host/latest?base=USD"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, _, _ in
            guard let jsonData = data else { return }
            
            
            do {
                let conversion = try JSONDecoder().decode(Conversion.self, from: jsonData)
                DispatchQueue.main.async {
                    let conversionData = conversion.rates.compactMap({ key, value in
                        
                        return FetchingCurrency(currencyName: key, currencyValue: value)
                    })
                    self.getCurrency(conversionData: conversionData)
                    
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func addReminder(reminder: Reminder) {
        reminders.append(reminder)
        NotificationManager.instance.scheduleNotification(reminder: reminder)
        saveReminders()
    }
    
    func removeReminder(uuid: UUID) {
        if let index = reminders.firstIndex(where: {$0.id == uuid}) {
            reminders.remove(at: index)
            saveReminders()
        }
    }

    func loadReminders() {
        if let savedReminders = UserDefaults.standard.object(forKey: remindersKeyName) as? Data {
            if let items = try? JSONDecoder().decode([Reminder].self, from: savedReminders) {
                self.reminders = items
            }
        }
    }
    
    func removeOldReminder() {
        let filterReminders = self.reminders.filter { remider in
            remider.date.timeIntervalSince1970 >= Date().timeIntervalSince1970
        }
        self.reminders = filterReminders
        saveReminders()
        
    }
    
    private func saveReminders() {
        if let encoded = try? JSONEncoder().encode(reminders) {
            UserDefaults.standard.set(encoded, forKey: remindersKeyName)
        }
    }
    
    func getWidthEqualScreen(_ currentWidth: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let ratio: CGFloat = currentWidth / 390
        let widthEqualScreen = screenWidth * ratio
        return widthEqualScreen
    }
    
    
    
    func isSSNValid(_ snn: String) -> Bool {
        var isSSNValid = false
        let SSNPattern = #"^\d{4}$"#
        if !snn.isEmpty {
            isSSNValid = snn.range(of: SSNPattern, options: .regularExpression) != nil && snn != "0000"
        }
        return isSSNValid
    }
    
    
    func isEmailValid(_ email: String) -> Bool {
        var isEmailValid = false
        let emailPattern = #"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"#
        if !email.isEmpty {
            isEmailValid = email.range(of: emailPattern, options: .regularExpression) != nil
        }
        return isEmailValid
    }
    
    
    
    func getCurrentDay(date: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "us")
        dateFormatterPrint.dateFormat = "E, d MMM yyyy, HH:mm"
        
        return dateFormatterPrint.string(from: date)
    }
    
    func getSeletedDay(date: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "us")
        dateFormatterPrint.dateFormat = "MMM d, yyyy"
        
        return dateFormatterPrint.string(from: date)
    }
    
    func getSeletedHours(date: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "us")
        dateFormatterPrint.dateFormat = "HH"
        
        return dateFormatterPrint.string(from: date)
    }
    
    func getSeletedMinute(date: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale(identifier: "us")
        dateFormatterPrint.dateFormat = "mm"
        
        return dateFormatterPrint.string(from: date)
    }
    
    func getDaysLeft(date: Date) -> Int {
        var daysLeft = 0
        let calendar = Calendar.current
        let currentDate = Date()
        
        let days = calendar.dateComponents([.day], from: currentDate, to: date)
        if let leftDay = days.day {
            daysLeft = leftDay
        }
        return daysLeft
    }
    
    
    
    internal func getFlag(from countryCode: String) -> String {
        let code = getCountryCode(code: countryCode)
        return code
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
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
    
    
    func calulate(loan: Double, rate: Double, term: Double) -> String {
        
        // переплата = (сумма займа * процентная ставка) / 100 * срок
        // сумма к выплате = сумма займа + переплата
        let op = (loan * rate) / 100 * term
        let b = op + loan
        let m = b / term
//        print("Переплата", op)
//        print("Общая сумма к возврату", b)
//        print("Выплата в месяц", m)
        
        
        return String(format:"%.0f", m)
    }
    
    
    
     func getURlfromRemoteConfig(email: String, snn: String, loanAmount: Double) -> String {
         
        let amount = getLoanAmount(selectedLoan: loanAmount)
        
        var urlStr = FirebaseManager.urlString
        urlStr = urlStr.replacingOccurrences(of: "{email}", with: email)
        urlStr = urlStr.replacingOccurrences(of: "{ssn}", with: snn)
        urlStr = urlStr.replacingOccurrences(of: "{requested_amount}", with: amount)
        
        
       return urlStr
    }
    
    
   private func getLoanAmount(selectedLoan: Double) -> String {

        let range =  [200...500, 500...1000, 1000...2500, 2500...5000]
        
        for r in range {
            if r.contains(Int(selectedLoan)) {
                if let max = r.max() {
                    return "\(max)"
                } else {
                    return "200"
                }
                
            } else {
            return "200"
            }
        }
        return  "200"
    }
    
}


