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
    @State var search: String = ""
    @State var show: Bool = false
//    @State var wubi: Wubi = previewWord
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
            WubiMacContentView(
                columnVisibility: .all,
                selectionIndex: 0,
                searchSelectionIndex: "0",
                favoriteSelectionIndex: "0",
                searchString: ""
            )
        }
        .modelContainer(modelContainer)
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
    }

//    func runSearch() {
//        do {
//            try self.wubi = Database.shared!.query(keyValue:search)
//        } catch {
//            //do nothing
//            print("search error: \(error)")
//        }
//    }
}

struct MenuItem: Identifiable {
    var id: Int
    let name: String
    let icon: String
}

let menuItems: [MenuItem] = [MenuItem(id: 0, name: "查找", icon: "magnifyingglass"),
                             MenuItem(id: 1, name: "历史", icon: "doc.text.magnifyingglass"),
                             MenuItem(id: 2, name: "收藏", icon: "star"),
                             MenuItem(id: 3, name: "关于", icon:  "person"),]

struct WubiMacContentView: View {
    @State var columnVisibility: NavigationSplitViewVisibility = .all
    @State var selectionIndex: Int

    @State var searchSelectionIndex: String
    @StateObject var searchState = SearchViewState()

    @State var favoriteSelectionIndex: String
    @StateObject var favoriteState = FavoriteViewState()
    @State var searchString: String
    var body: some View  {
        NavigationSplitView(columnVisibility: $columnVisibility, sidebar:  {
            List(menuItems,selection: $selectionIndex) { item in
                SideBarLabel(title: item.name, imageName: item.icon)
            }
        }, content: {
            switch selectionIndex {
                case 0: SearchListView(selectionIndex: $searchSelectionIndex)
                        .environmentObject(searchState)
                case 1: SearchHistoryView()
                case 2: FavoriteListView(selectionIndex: $favoriteSelectionIndex)
                        .environmentObject(favoriteState)
                default: Text("")
            }
        },  detail: {
            switch selectionIndex {
                case 0:
                    if searchState.wubis.count == 0 {
                        Text("")
                    } else {
                        if let wubi = $searchState.wubis.first(where: { $0.id == searchSelectionIndex }) {
                            WubiDetailView(wubi:wubi, action: {})
                        } else {
                            WubiDetailView(wubi:$searchState.wubis.first!, action: {})
                        }
                    }
                case 1:
                    Text("")
                case 2: //AboutView()

                    if favoriteState.favoriteWords.count == 0 {
                        Text("您还未收藏任何内容")
                    } else {
                        if let wubi = $favoriteState.favoriteWords.first(where: { $0.id == favoriteSelectionIndex }) {
                            WubiDetailView(wubi:wubi, action: { favoriteState.getFavoriteWords() })
                        } else {
                            WubiDetailView(wubi:$favoriteState.favoriteWords.first!, action: {})
                        }
                    }
                default:
                    Text("")
            }
        })
        .frame(minWidth: 1250, minHeight: 650)
        .navigationTitle("98五笔")
    }
}
