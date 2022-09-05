//
//  CurrencyCard.swift
//  pdl
//
//

import SwiftUI

struct CurrencyCard: View {
    let currency: Currency
    
    var body: some View {
        HStack(spacing: 0) {
            flagView()
            VStack(alignment: .leading) {
                Text(currency.currencyFullName)
                    .font(.semibold18())
                    .foregroundColor(.black)
                Text(currency.currencyName)
                    .font(.regular16())
                    .foregroundColor(Color(hex: "333333"))
            }
            Spacer()
            Text(currency.currencyValue)
                .font(.semibold18())
                .foregroundColor(.black)
        }
        .padding(.trailing)
        .background (
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
                .shadow(radius: 4)
        )
        .padding()
    }
    
    
    private func flagView() -> some View {
        ZStack {
            Text(currency.flag)
                .font(.system(size: 78))
            
            Circle()
                .stroke(
                    Color.white,
                    style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .frame(width: 64, height: 64)
        }
    }
    
}




struct CurrencyCard_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyCard(currency: Currency(flag: "🇹🇨",
                                        currencyName: "PLN",
                                        currencyFullName: "Zloty",
                                        currencyValue: "10.00"))
    }
}
