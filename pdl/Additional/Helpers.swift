//
//  Helpers.swift
//  pdl
//
//

import SwiftUI

struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color.clear
        .overlay(content)
    }
}
