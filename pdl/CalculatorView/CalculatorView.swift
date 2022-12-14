//
//  CalculatorView.swift
//  pdl
//
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var model: CalculatorViewModel = CalculatorViewModel()
    @State private var selectedLoanAmount: Double = 2500.0
    @State private var selectedInterestRate: Double = 50.0
    @State private var selectedLoanTermInMonth: Double = 18.0
    @State private var isEditing = false
    private let isSmall = UIScreen.main.bounds.width == 375
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(step: nil, title: "Loan calculator", imageSize: model.getWidthEqualScreen(52))
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    resultsView()
                        .shadow(radius: 4)
                    SlidersView()
                        .shadow(radius: 4)
                }
            }
        }
        .background(Color(hex: "F7F7F7")
            .ignoresSafeArea(.all)
        )
    }
    
    private func resultsView() -> some View {
        VStack(spacing: 15) {
            VStack(spacing: 5) {
                Text("$\(model.calulate(loan: selectedLoanAmount, rate: selectedInterestRate, term: selectedLoanTermInMonth))")
                    .font(.bold30())
                    .foregroundColor(.white)
                    .accessibilityIdentifier("MonthlyPayment")
                Text("Est. Monthly Payment")
                    .font(.regular16())
                    .foregroundColor(.white)
            }
            HStack {
                Text("This loan will really cost you")
                    .font(.medium12())
                    .foregroundColor(Color(hex: "CACACA"))
                Spacer()
                Text("$\(model.getFullAmount(loan: selectedLoanAmount, rate: selectedInterestRate, term: selectedLoanTermInMonth))")
                    .font(.medium12())
                    .foregroundColor(Color(hex: "CACACA"))
                    .accessibilityIdentifier("LoanCost")
            }
        }
        .padding(.vertical)
        .padding()
        .background(BackgroundCard())
        .padding()
        
    }
    
    
    
    
    private func SlidersView() -> some View {
        VStack(alignment: .center, spacing: isSmall ? 20 : 40) {
            loanAmountView()
            interestRateView()
            loanTermInMonthView()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding()
    }
    
    
    private func loanAmountView() -> some View {
        VStack {
            HStack() {
                Text("Loan Amount")
                    .font(.semibold18())
                    .foregroundColor(.black)
                Spacer()
                Text("$\(Int(selectedLoanAmount))")
                    .font(.bold30())
                    .foregroundColor(.black)
                    .accessibilityIdentifier("LoanAmountSliderResult")
            }
            
            
            Slider(
                value: $selectedLoanAmount,
                in: 200...5000,
                step: 100
            ) {
                
            } minimumValueLabel: {
                Text("200")
                    .font(.semibold18())
                    .foregroundColor(Color(hex: "828282"))
            } maximumValueLabel: {
                Text("5000")
                    .font(.semibold18())
                    .foregroundColor(Color(hex: "828282"))
            } onEditingChanged: { editing in
                isEditing = editing
            }
            .accentColor(Color(hex: "34CB81"))
            .accessibilityIdentifier("LoanAmountSlider")
            
        }
    }
    
    private func interestRateView() -> some View {
        VStack {
            HStack() {
                Text("Interest rate")
                    .font(.semibold18())
                    .foregroundColor(.black)
                Spacer()
                Text("\(Int(selectedInterestRate))%")
                    .font(.bold30())
                    .foregroundColor(.black)
                    .accessibilityIdentifier("InterestRateSliderResult")
            }
            
            
            Slider(
                value: $selectedInterestRate,
                in: 0...100,
                step: 1
            ) {
                
            } minimumValueLabel: {
                Text("0%")
                    .font(.semibold18())
                    .foregroundColor(Color(hex: "828282"))
            } maximumValueLabel: {
                Text("100%")
                    .font(.semibold18())
                    .foregroundColor(Color(hex: "828282"))
            } onEditingChanged: { editing in
                isEditing = editing
            }
            .accentColor(Color(hex: "34CB81"))
            .accessibilityIdentifier("InterestRateSlider")
            
        }
    }
    
    private func loanTermInMonthView() -> some View {
        VStack {
            HStack() {
                Text("Loan term  in month")
                    .font(.semibold18())
                    .foregroundColor(.black)
                Spacer()
                Text("\(Int(selectedLoanTermInMonth))")
                    .font(.bold30())
                    .foregroundColor(.black)
                    .accessibilityIdentifier("  ")
            }
            
            
            Slider(
                value: $selectedLoanTermInMonth,
                in: 1...36,
                step: 1
            ) {
                
            } minimumValueLabel: {
                Text("01")
                    .font(.semibold18())
                    .foregroundColor(Color(hex: "828282"))
            } maximumValueLabel: {
                Text("36")
                    .font(.semibold18())
                    .foregroundColor(Color(hex: "828282"))
            } onEditingChanged: { editing in
                isEditing = editing
            }
            .accentColor(Color(hex: "34CB81"))
            .accessibilityIdentifier("LoanTermInMonthSlider")
            
        }
    }
}

