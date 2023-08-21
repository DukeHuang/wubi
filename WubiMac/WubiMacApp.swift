//
//  WubiMacApp.swift
//  WubiMac
//
//  Created by yongyou on 2023/7/3.
//

import SwiftUI

 @main
struct WubiMacApp: App {
    @State var search: String = ""
    @State var show: Bool = false
    @State var wubi: Wubi = previewWord

    var body: some Scene {
        WindowGroup {
            WubiMacContentView(
                columnVisibility: .all,
                selectionIndex: 0,
                favoriteSelectionIndex: "0",
                searchString: ""
            )
        }
        MenuBarExtra("五笔查询", systemImage: "magnifyingglass.circle") {
            TextField("请输入要查询的汉字",text: $search)
            .onSubmit {
                self.runSearch()
                if self.wubi.character.count > 0 {
                    show = true
                } else {
                show = false
                }
            }.keyboardShortcut("s")
            WubiMenuBarDetailView(wubi: $wubi) {}.opacity(show ? 0 : 1)
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }.menuBarExtraStyle(.window)
    }

    func runSearch() {
        do {
            try self.wubi = Database.shared!.query(keyValue:search)
        } catch {
            //do nothing
            print("search error: \(error)")
        }
    }
}

struct MenuItem: Identifiable {
    var id: Int
    let name: String
    let icon: String
}

let menuItems: [MenuItem] = [MenuItem(id: 0, name: "查找", icon: "magnifyingglass"),
                             MenuItem(id: 1, name: "收藏", icon: "star")]

struct WubiMacContentView: View {
    @State var columnVisibility: NavigationSplitViewVisibility
    @State var selectionIndex: Int
    @State var favoriteSelectionIndex: String
    @StateObject var favoriteState = FavoriteViewState()
    @State var searchString: String
    var body: some View  {
        NavigationSplitView(columnVisibility: $columnVisibility, sidebar:  {
            List(menuItems,selection: $selectionIndex) { item in
                SideBarLabel(title: item.name, imageName: item.icon)
            }
        }, content: {
            if selectionIndex == 0 {
                SearchListView()
            }
             if selectionIndex == 1 {
                FavoriteListView(selectionIndex: $favoriteSelectionIndex)
                    .environmentObject(favoriteState)
            }
        },  detail: {
            if selectionIndex == 0 {
                SearchView()
            } else if selectionIndex == 1 && favoriteState.favoriteWords.count > 0 {
                WubiDetailView(wubi:$favoriteState.favoriteWords.first(where: {
                    $0.id == favoriteSelectionIndex }) ?? $favoriteState.favoriteWords.first!,
                               action: {
                    favoriteState.getFavoriteWords()
                    }
                )
            }
        })
        .frame(minWidth: 1250, minHeight: 650)
        .navigationTitle("98五笔")
    }
}
