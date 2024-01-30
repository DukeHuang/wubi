//
//  WubiMacApp.swift
//  WubiMac
//
//  Created by yongyou on 2023/7/3.
//

import SwiftUI
import SwiftData

@main
struct WubiMacApp: App {
    let modelContainer: ModelContainer
    init() {
        do {
            modelContainer = try ModelContainer(for: Wubi.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    var body: some Scene {
        WindowGroup {
            WubiMacContentView()
        }
        .modelContainer(modelContainer)
    }
}

extension WubiMacApp {
    //    @State var search: String = ""
    //    @State var show: Bool = false

    //        MenuBarExtra("五笔查询", systemImage: "magnifyingglass.circle") {
    //            TextField("请输入要查询的汉字",text: $search)
    //            .onSubmit {
    //                self.runSearch()
    //                if self.wubi.character.count > 0 {
    //                    show = true
    //                } else {
    //                show = false
    //                }
    //            }.keyboardShortcut("s")
    //            WubiMenuBarDetailView(wubi: $wubi) {}.opacity(show ? 0 : 1)
    //            Button("Quit") {
    //                NSApplication.shared.terminate(nil)
    //            }.keyboardShortcut("q")
    //        }.menuBarExtraStyle(.window)


    //    func runSearch() {
    //        do {
    //            try self.wubi = Database.shared!.query(keyValue:search)
    //        } catch {
    //            //do nothing
    //            print("search error: \(error)")
    //        }
    //    }
}




