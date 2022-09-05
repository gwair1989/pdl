//
//  LoanViewModel.swift
//  pdl
//
//  Created by Oleksandr Khalypa on 05.09.2022.
//

import Foundation


class LoanViewModel: ObservableObject, ProtocolsViewModel {
    
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
    
    func getURlfromRemoteConfig(url: String, email: String, snn: String, loanAmount: Double) -> String {
         
        let amount = getLoanAmount(selectedLoan: loanAmount)
        
        var urlStr = url
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
