//
//  ProfileSubView.swift
//  pdl
//
//  Created by Oleksandr Khalypa on 31.08.2022.
//

import SwiftUI

struct ProfileSubView: View {
    let model: BaseViewModel
    
    var body: some View {
        BaseView(title: model.titleView) {
            ForEach(model.cards.indices, id: \.self) { i in
                ProfileViewCard(card: model.cards[i], isRequirements: model.titleView == "Requirements", isLast: i == model.cards.count - 1)
                    .shadow(radius: 3)
            }
        }
    }
}


