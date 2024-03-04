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

struct TypingView: View {

    @State private var label: String = ""
    var body: some View {
        VStack {
            HStack {
                Button {

                } label: {
                    Text("打乱")
                }
                Button {

                } label: {
                    Text("重打")
                }
                Button {

                } label: {
                    Text("暂停")
                }
                Button {

                } label: {
                    Text("继续")
                }

                Spacer()

                Text("6/100")

                Text("1/1")

                Spacer()

                Button {

                } label: {
                    Text("文章选择")
                }
                Button {

                } label: {
                    Text("文章自定义")
                }

                Spacer()
                Button {

                } label: {
                    Text("5")
                }
                Button {

                } label: {
                    Text("10")
                }
                Button {

                } label: {
                    Text("15")
                }
                Button {

                } label: {
                    Text("20")
                }
                Button {

                } label: {
                    Text("50")
                }
                Button {

                } label: {
                    Text("100")
                }
                Button {

                } label: {
                    Text("200")
                }
                Button {

                } label: {
                    Text("500")
                }
                Button {

                } label: {
                    Text("全")
                }

                Spacer()

                Button {

                } label: {
                    Text("极简模式")
                }
            }

            Text("的一是了不在有个人这上中大为来我到出要以时和地们得可下对生也子就过能他会多发说而于自之用年行家方后作成开面事好小心前所道法如进着同经分定都然与本还其当起动已两点从问里主实天高去现长此三将无国全文理明日些看只公等十意正外想间把情者没重相那向知因样学应又手但信关使种见力名二处门并口么先位头回话很再由身入内第平被给次别几月真立新通少机打水果最部何安接报声才体今合性西你放表目加常做己老四件解路更走比总金管光工结提任东原便美及教难世至气神山数利书代直色场变记张必受交非服化求风度太万各算边王什快许连五活思该步海指物则女或完马强言条特命感清带认保望转传儿制干计民白住字它义车像反象题却流且即深近形取往系量论告息让决未花收满每华业南觉电空眼听远师元请容她军士百办语期北林识半夫客战院城候单音台死视领失司亲始极双令改功程爱德复切随李员离轻观青足落叫根怎持精送众影八首包准兴红达早尽故房引火站似找备调断设格消拉照布友整术石展紧据终周式举飞片虽易运笑云建谈界务写钱商乐推注越千微若约英集示呢待坐议乎留称品志黑存六造低江念产刻节尔吃势依图共曾响底装具喜严九况跟罗须显热病证刚治绝群市阳确究久除闻答段官政类黄武七支费父统")
                .border(.secondary)

            TextField(
                "",
                text: $label,
                axis: .vertical
            )
            .textFieldStyle(.roundedBorder)
            .frame(height: 500)
//            .padding()
        }
    }
}

#Preview {
    TypingView()
}
