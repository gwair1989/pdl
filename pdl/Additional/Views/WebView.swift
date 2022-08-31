//
//  WebView.swift
//  pdl
//
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let urlString: String
    
    @Binding var showLoading: Bool
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        print(urlString)
        if let url = URL(string: urlString)  {
        let request = URLRequest(url: url)
        webView.load(request)
        }
        return webView
    }
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator {
            showLoading = true
        } didFinish: {
            showLoading = false
        }

    }
    
}

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    
    var didStart: () -> Void
    var didFinish: () -> Void
    
    init(didStart: @escaping ()-> Void = {}, didFinish: @escaping ()-> Void = {}) {
        self.didStart = didStart
        self.didFinish = didFinish
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        didStart()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        didFinish()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    
}
