//
//  CurrencyView.swift
//  pdl
//
//

import SwiftUI

struct CurrencyView: View {
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(step: nil, title: "Current exchange", imageSize: model.getWidthEqualScreen(52))
            headerView()
            if model.currences.isEmpty {
                ProgressView()
            } else {

                ScrollView {
                    VStack(alignment: .center, spacing: 0) {
                        ForEach(model.currences) { currency in

                            CurrencyCard(currency: currency)

                        }
                    }

                }
            }
            
            Spacer()
        }
    }
    
    
    
    
    private func titleView() -> some View {
            HStack {
                Spacer()
                Text("USD-USA")
                    .font(.semibold22())
                    .foregroundColor(.black)
                Spacer()
            }
            .background(Color.white.edgesIgnoringSafeArea(.top))
            .padding()
    }
    
    
    private func headerView() -> some View {
        HStack {
           Text("Currency")
                .font(.medium16())
                .foregroundColor(Color(hex: "797979"))
            Spacer()
            HStack(spacing: 25) {
                Text("Buy $")
                    .font(.medium16())
                    .foregroundColor(Color(hex: "797979"))
            }
        }
        .padding(.horizontal)
        .padding()
        .background(Color(hex: "E8E8E8"))
        
    }
    
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
