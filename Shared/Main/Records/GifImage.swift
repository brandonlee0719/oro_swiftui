//
//  GifImage.swift
//  ORO (iOS)
//
//  Created by MAC on 2022/11/19.
//

import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    private let name: String
    
    init(_ name: String) {
        self.name = name
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        let url = Bundle.main.url(forResource: name, withExtension: "gif")
        let data = try! Data(contentsOf: url!)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url!.deletingLastPathComponent()
        )
        
        return webView
    }

    func updateUIView(_ uiView:WKWebView, context: Context) {

    }
}

struct GifImage_Previews: PreviewProvider {
    static var previews: some View {
        GifImage("audio_player")
    }
}
