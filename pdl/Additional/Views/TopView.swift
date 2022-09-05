//
//  TopView.swift
//  pdl
//
//

import SwiftUI

struct TopView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Button {
                action()
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(.black)
            }
            
            Text(title)
                .font(.semibold30())
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding()
        .background(Color.white.ignoresSafeArea(.all))
    }
}

