//
//  BaseView.swift
//  pdl
//
//

import SwiftUI

struct BaseView: View {
    let model: BaseViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack(spacing: 0) {
            TopView(title: model.titleView) {
                presentationMode.wrappedValue.dismiss()
            }
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 0) {
                    ForEach(model.cards) { card in

                        BaseViewCard(card: card)
                            .shadow(radius: 3)

                    }
                }
            }
           
            .background(Color(hex: "F7F7F7")
                .ignoresSafeArea(.all))
        }
        .navigationBarHidden(true)
        
    }
    


    
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView(model: BaseViewModel.profileModels[0])
    }
}
