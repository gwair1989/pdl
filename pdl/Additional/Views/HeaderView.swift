//
//  HeaderView.swift
//  pdl
//
//

import SwiftUI

struct HeaderView: View {
    let step: Int?
    let title: String
    let imageSize: CGFloat
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                if let currentStep = step {
                    Text("Step \(currentStep)")
                        .font(.semibold18())
                        .foregroundColor(Color(hex: "BDBDBD"))
                }
                Text(title)
                    .font(.semibold30())
                    .foregroundColor(.black)
            }
            Spacer()
            NavigationLink {
                ProfileView()
            } label: {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: imageSize))
                    .foregroundColor(Color(hex: "BDBDBD"))
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
        .background(Color.white.ignoresSafeArea(.all))
    }
    
    
    
    
}

