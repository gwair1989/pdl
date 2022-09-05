//
//  Flashcard.swift
//  pdl
//
//

import SwiftUI

struct Flashcard<Front, Back>: View where Front: View, Back: View {
    var heightCard: CGFloat
    @State var isBackEmpty: Bool
    var bacgroundImage: String = ""
    var front: () -> Front
    var back: () -> Back
    @State private var flipped: Bool = false
    @State private var flashcardRotation = 0.0
    @State private var contentRotation = 0.0
    
    init(heightCard: CGFloat, isBackEmpty: Bool, bacgroundImage: String, @ViewBuilder front: @escaping () -> Front, @ViewBuilder back: @escaping () -> Back) {
        self.heightCard = heightCard
        self.isBackEmpty = isBackEmpty
        self.bacgroundImage = bacgroundImage
        self.front = front
        self.back = back
    }
    
    var body: some View {
        ZStack {
            if flipped {
                back()
            } else {
                front()
            }
        }
        .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
        .padding()
        .frame(minHeight: heightCard)
        .frame(maxWidth: .infinity)
        .background(backgroundView())
        .cornerRadius(10)
        .padding()
        .onTapGesture {
            if !isBackEmpty {
                flipFlashcard()
            }
        }
        .rotation3DEffect(.degrees(flashcardRotation), axis: (x: 0, y: 1, z: 0))
    }
    
    private func backgroundView() -> some View {
        ZStack {
            if bacgroundImage.isEmpty {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
            } else {
                Image(bacgroundImage).resizable().scaledToFill()
            }
        }
    }
    
    
    func flipFlashcard() {
        let animationTime = 0.5
        withAnimation(Animation.linear(duration: animationTime)) {
            flashcardRotation += 180
        }
        
        withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
            contentRotation += 180
            flipped.toggle()
        }
    }
}
