//
//  ContentView.swift
//  Wubi
//
//  Created by yongyou on 2020/7/14.
//  Copyright © 2020 sakuragi. All rights reserved.
//

import SwiftUI

/*
#if targetEnvironment(macCatalyst)

// 捕获系统键盘事件
struct KeyEventHandling: NSViewRepresentable {
    var state: ContentViewState
    class KeyView: NSView {
        var state: ContentViewState = ContentViewState()
        override var acceptsFirstResponder: Bool { true }
        override func keyDown(with event: NSEvent) {
            if state.fiveStroke.key == event.charactersIgnoringModifiers {
                state.check = .correct
                state.fiveStroke.random()
                state.database.addShowCount(keyValue: state.fiveStroke.imageName)
            } else {
                state.check = .error
                state.database.addErrorCount(keyValue: state.fiveStroke.imageName)
            }
        }
    }

    func makeNSView(context: Context) -> NSView {
        let view = KeyView()
        view.state = self.state
        view.state.database.db_FiveTypistPractise = view.state.database.openDatabaseFiveTypistPractise()
        view.state.database.db_FiveTypistWord = view.state.database.openDatabaseWord()

        DispatchQueue.main.async { // wait till next event cycle
            view.window?.makeFirstResponder(view)
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
    }
}

#endif
 */

struct ContentView: View {

    @ObservedObject var state: ContentViewState = ContentViewState()
    @State private var searchWord: String = "黄"
    @State private var result: FiveTypist = FiveTypist(character: "",
                                                       components: "",
                                                       jianma: "",
                                                       quanma: "",
                                                       jianmaKeys: [""],
                                                       quanmaKeys: [""],
                                                       pingyin: "",
                                                       isFavorite: false) //查询结果信息


    @EnvironmentObject var modelData: ModelData
    @State private var isFavorite: Bool = false
    var body: some View {
            List {

                HStack {
                    Text(searchWord)
                        .font(.largeTitle)
                        .bold()
                    Text(self.result.pingyin)
                        .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                        .foregroundStyle(.white)
                        .background(.teal)
                        .cornerRadius(3)
                    FavoriteButton(isSet: $isFavorite)
                }

                Section("拆字:") {
                    Text(self.result.components.filter { $0 != "〔" && $0 != "〕" && $0 != "※" })
                        .font(.title)
                }
                Section("简码:") {
                    Text(self.result.jianma.uppercased())
                    SingleKeyBoardView(quanma:self.result.jianmaKeys)
                }

                Section("全码:") {
                    Text(self.result.quanma.uppercased())
                    SingleKeyBoardView(quanma:self.result.quanmaKeys)
                }

                HighlightedImage(keys: self.result.quanmaKeys)
            }
            .searchable(text: $searchWord,prompt: "请输入要查询的字")
            .onAppear(perform: runSearch)
            .onSubmit(of:.search, runSearch)
    }

    private func splitComponents(_ components: String) -> String {
        //〔※󰁺※󰃙※󰄦※󰁧※〕
        return components.filter { $0 != "〔" && $0 != "〕" && $0 != "※" }
    }

    func runSearch() {
        do {
            try self.result = self.state.database.query(keyValue:searchWord)
        } catch {
            //do nothing
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
