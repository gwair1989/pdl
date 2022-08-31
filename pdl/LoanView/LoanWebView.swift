//
//  LoanWebView.swift
//  pdl
//
//

import SwiftUI

struct LoanWebView: View {
    @State private var showLoading: Bool = false
    let urlString: String
    var body: some View {
        VStack {
            WebView(urlString: urlString, showLoading: $showLoading)
                .overlay(showLoading ? ProgressView().toAnyView() : EmptyView().toAnyView())
        }
    }
}

//struct LoanWebView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoanWebView()
//    }
//}
