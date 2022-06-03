//
//  WebView.swift
//  marvel-api-app
//
//  Created by KimJongHee on 2022/06/03.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: url))

        return view
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    

}


