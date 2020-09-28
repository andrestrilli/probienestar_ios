//
//  WebView.swift
//  enjoitIos
//
//  Created by developapp on 13/05/20.
//  Copyright © 2020 developapp. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit

struct Webview: UIViewRepresentable{
    
    var url:String
    
    
    func makeUIView(context: Context) -> WKWebView {
        
        guard let url = URL(string: self.url) else {
            return  WKWebView()
        }
        
        let request = URLRequest(url: url)
        let wkwebview =  WKWebView()
        wkwebview.load(request)
        return wkwebview
        
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<Webview>) {
        
    }
    
}
