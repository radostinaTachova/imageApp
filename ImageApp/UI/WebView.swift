//
//  WebView.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 2/11/23.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
   
    let url: URL
    
    let loginURL: (String) -> () //TODO:

    func makeUIView(context: Context) -> WKWebView {
        let wKWebView = WKWebView()
        wKWebView.navigationDelegate = context.coordinator
        return wKWebView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(self)
    }
    
    //
    class WebViewCoordinator: NSObject, WKNavigationDelegate {
            var parent: WebView
            
            init(_ parent: WebView) {
                self.parent = parent
            }
            
            func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
                let urlToMatch = "https://imageapp.com"
                //TODO: add extension to check
                if let urlStr = navigationAction.request.url?.absoluteString {
                    print("RTC = webview coordinator = \(urlStr)")
                   
                    
                    if urlStr.contains(urlToMatch) {
                        print("RTC = login YESS")
                        parent.loginURL(urlStr)
                    }
                }
                decisionHandler(.allow)
            }
            
        }
}
