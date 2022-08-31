//
//  BaseViewCard.swift
//  pdl
//
//

import SwiftUI

struct BaseViewCard: View {
    let card: Card
    
    var body: some View {
        
        Flashcard(isBackEmpty: card.descriptionCard.isEmpty, bacgroundImage: card.image) {
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
                .font(.medium18())
                .foregroundColor(.black)
            
        }
    }
    
    private func backView() -> some View {
        ExpandableText(card.descriptionCard, lineLimit: 7)
        
    }
    
}


struct BaseViewCard_Previews: PreviewProvider {
    static var previews: some View {
        BaseViewCard(card: BaseViewModel.profileModels[0].cards[0])
    }
}
