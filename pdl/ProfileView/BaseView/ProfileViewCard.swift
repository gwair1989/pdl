//
//  BaseViewCard.swift
//  pdl
//
//

import SwiftUI

struct ProfileViewCard: View {
    let card: Card
    let isRequirements: Bool
    let isLast: Bool
    
    var body: some View {
        Flashcard(heightCard: !isRequirements ? 200 : isLast ? 300 : 150, isBackEmpty: card.descriptionCard.isEmpty, bacgroundImage: card.image) {
            frontView()
        } back: {
            backView()
        }
    }
    
    private func frontView() -> some View {
        VStack(alignment: .center, spacing: 14) {
            if !card.descriptionCard.isEmpty {
                Text("Tap to Read")
                    .font(.medium18())
                    .foregroundColor(Color(hex: "E6E6E6"))
            }
            Text(card.titleCard)
                .multilineTextAlignment(.center)
                .font(isRequirements ? .semibold22() : .medium18())
                .foregroundColor(isRequirements ? .white : .black)
        }
    }
    
    private func backView() -> some View {
        ExpandableText(card.descriptionCard, lineLimit: 7)
        
    }
    
}


struct ProfileViewCard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileViewCard(card: BaseViewModel.profileModels[0].cards[0], isRequirements: false, isLast: false)
    }
}
