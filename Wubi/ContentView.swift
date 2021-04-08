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
//            super.keyDown(with: event)
            if state.fiveStroke.key == event.charactersIgnoringModifiers {
                state.check = .right
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
        view.state.database.db = view.state.database.openDatabase()
        view.state.database.db1 = view.state.database.openDatabase1()

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
    @State var searchWord: String = ""

    let arrays: [(String,String,String)] = [("1","2","3"),("11","22","33")]
//    let arrays = ["1","2","3"]

    var body: some View {
        NavigationView {
            List(titles, id:\.self) { title in
                if  title == "字根练习" {
                    NavigationLink(
                        destination: VStack (alignment: .leading) {
                            if state.check == .error {
                                Text(state.fiveStroke.key)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .frame(maxWidth:.infinity)
                                    .padding()
                                Image(state.fiveStroke.imageName)
                                    .background(KeyEventHandling(state:state))
                                    .scaledToFit()
                                    .frame(width: 500, height: 100, alignment: .center)
                                Spacer()
                                Image(state.fiveStroke.tipsImageName)
                                    .frame(width: 500, height: 100, alignment: .center)
                                    .scaledToFit()
                                Text(state.fiveStroke.verse)
                                    .font(.title)
                                    .frame(maxWidth:.infinity)
                                    .padding()
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
                    NavigationLink(
                        destination: VStack (alignment: .leading) {
                            VStack(alignment: .leading) {
                                TextField("Enter username...", text: $searchWord)
                                Text("Your username: \(searchWord)")
                            }.padding()
                        },
                        label: {
                            Text(title)
                        })
                } else {
                    NavigationLink(
                        destination: VStack (alignment: .leading) {
                            TextField("输入要查询的单字", text: $searchWord)
                            VStack(alignment: .leading) {
                                Text("\(self.state.database.query(keyValue: searchWord)?.character ?? "")")
                                Text("\(self.state.database.query(keyValue: searchWord)?.components ?? "")")
                                Text("\(self.state.database.query(keyValue: searchWord)?.alphabetical ?? "")")
                                Text("\(self.state.database.query(keyValue: searchWord)?.all_alphabetical ?? "")")
                                Text("\(self.state.database.query(keyValue: searchWord)?.pingyin ?? "")")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
