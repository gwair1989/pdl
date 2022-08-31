//
//  BackgroundReminderCard.swift
//  pdl
//
//

import SwiftUI

struct BackgroundCard: View {
    var body: some View {
        ZStack {
            
            Circle()
                .frame(width: 347, height: 347)
                .foregroundColor(.white).opacity(0.05)
                .position(x: 278, y: 150)
            
            
            Circle()
                .frame(width: 368, height: 348)
                .foregroundColor(.white).opacity(0.08)
                .position(x: 380, y: 210)
            
            
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(hex: "333333"))
        )
        .clipped()  
    }
}

struct BackgroundReminderCard_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundCard()
    }
}
