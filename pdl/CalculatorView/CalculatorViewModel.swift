//
//  CalculatorViewModel.swift
//  pdl
//
//  Created by Oleksandr Khalypa on 05.09.2022.
//

import Foundation


class CalculatorViewModel: ObservableObject, ProtocolsViewModel {
    
    
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
    
    func getFullAmount(loan: Double, rate: Double, term: Double) -> String {
        // переплата = (сумма займа * процентная ставка) / 100 * срок
        // сумма к выплате = сумма займа + переплата
        let op = (loan * rate) / 100 * term
        let b = op + loan
        //        let m = b / term
        //        print("Переплата", op)
        //        print("Общая сумма к возврату", b)
        //        print("Выплата в месяц", m)
        
        
        return String(format:"%.0f", b)
    }
}
