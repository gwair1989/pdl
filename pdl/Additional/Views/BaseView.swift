//
//  BaseView.swift
//  pdl
//
//

import SwiftUI

struct BaseView<BaseContent>: View where BaseContent: View {
    let title: String
    var content: () -> BaseContent
    @Environment(\.presentationMode) var presentationMode
    
    init(title: String, @ViewBuilder content: @escaping () -> BaseContent) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TopView(title: title) {
                presentationMode.wrappedValue.dismiss()
            }
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: 0) {
                    content()
                }
            }
            
            .background(Color(hex: "F7F7F7")
                .ignoresSafeArea(.all))
        }
        .navigationBarHidden(true)
        
    }

}
