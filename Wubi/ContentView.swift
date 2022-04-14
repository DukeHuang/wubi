//
//  ContentView.swift
//  Wubi
//
//  Created by yongyou on 2020/7/14.
//  Copyright © 2020 sakuragi. All rights reserved.
//

import SwiftUI

/// 捕获系统键盘事件
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

struct ContentView: View {
    @EnvironmentObject  var state: ContentViewState
    private let titles = ["字根练习","字根巩固","编码查询"]
    @State private var searchWord: String = ""
    @State private var typist: FiveTypist? //查询结果信息
    @State private var alphabeticals: [String]? //查询全码

    var body: some View {
        NavigationView {
            List(titles, id:\.self) { title in
                if  title == "字根练习" {
                    NavigationLink(
                        destination: VStack (
                            alignment: .leading,
                            spacing: 10
                        ){
                            if state.check == .error {
                                Text(state.fiveStroke.key)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Image(state.fiveStroke.imageName)
                                    .background(KeyEventHandling(state:state))
                                    .scaledToFit()
                                    .frame(width: 100, height: 100, alignment: .center)
                                Image(state.fiveStroke.tipsImageName)
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .scaledToFit()
                                Text(state.fiveStroke.verse)
                                    .font(.title)
                            } else {
                                Image(state.fiveStroke.imageName)
                                    .background(KeyEventHandling(state:state))
                                    .scaledToFit()
                                    .frame(width: 500, height: 100, alignment: .center)
                            }
                        },
                        label: {
                            Text(title)
                        })
                }
                else if title == "字根巩固" {
                    //
                } else {
                    NavigationLink(
                        destination: VStack (alignment: .leading) {
                            TextField("输入要查询的单字", text: $searchWord)
                            Button("search"){
                                self.typist = self.state.database.query(keyValue:searchWord)
                                self.alphabeticals = self.typist?.alphabeticals
                            }
                            VStack(alignment: .leading) {
                                Text("简码：\(self.typist?.character ?? "")").font(.largeTitle).fontWeight(.bold)
                                Text("拆字：\(self.typist?.components ?? "")").font(.largeTitle).fontWeight(.bold)
                                Text("简码：\(self.typist?.alphabetical ?? "")").font(.largeTitle).fontWeight(.bold)
                                Text("全码：\(self.typist?.all_alphabetical ?? "")").font(.largeTitle).fontWeight(.bold)
                                AlphabeticalView(alphs:self.alphabeticals ?? ["a"])
                                Text("拼音：\(self.typist?.pingyin ?? "")").font(.largeTitle).fontWeight(.bold)
                            }.padding()
                        },
                        label: {
                            Text(title)
                        })
                }
            }
        }
    }
}

//字母表
struct AlphabeticalView: View {
    var alphs: Array<String>

    var body: some View {
        HStack {
            ForEach(alphs.indices,id:\.self) { index in
                Image("\(alphs[index])_keyboard")
                    .frame(width: 100, height: 100, alignment: .center)
                    .scaledToFit()
                    .padding()
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
