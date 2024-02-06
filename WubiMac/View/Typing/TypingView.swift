//
//  TypingView.swift
//  WubiMac
//
//  Created by yongyou on 2024/1/15.
//

import SwiftUI
//import WebView
//
//struct TypingView: View  {
//    @StateObject var webViewStore = WebViewStore()
//
//    var body: some View {
//        NavigationStack {
//            WebView(webView: webViewStore.webView)
//                .navigationTitle(Text(verbatim: webViewStore.title ?? ""))
//                .toolbar(content: {
//                    HStack {
//                        Button(action: goBack) {
//                            Image(systemName: "chevron.left")
//                                .imageScale(.large)
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 32, height: 32)
//                        }.disabled(!webViewStore.canGoBack)
//                        Button(action: goForward) {
//                            Image(systemName: "chevron.right")
//                                .imageScale(.large)
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 32, height: 32)
//                        }.disabled(!webViewStore.canGoForward)
//                    }
//                })
//
//        }.onAppear {
//            if let url = Bundle.main.url(forResource: "typepadBundle", withExtension: "bundle"),
//               let bundle = Bundle(url: url),
//               let path = bundle.path(forResource: "index", ofType: "html") {
//                let url = URL(filePath: path)
//                self.webViewStore.webView.load(URLRequest(url: url))
//            }
//        }
//    }
//
//    func goBack() {
//        webViewStore.webView.goBack()
//    }
//
//    func goForward() {
//        webViewStore.webView.goForward()
//    }
//}
//
//#Preview {
//    TypingView()
//}
