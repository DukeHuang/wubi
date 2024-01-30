//
//  WubiMacContentView.swift
//  WubiMac
//
//  Created by yongyou on 2024/1/16.
//

import SwiftUI
import SwiftData


struct MenuItem: Identifiable {
    var id: Int
    let name: String
    let icon: String
}

let menuItems: [MenuItem] = [MenuItem(id: 0, name: "查找", icon: "magnifyingglass"),
                             MenuItem(id: 1, name: "历史", icon: "doc.text.magnifyingglass"),
                             MenuItem(id: 2, name: "收藏", icon: "star"),
                             MenuItem(id: 3, name: "跟打", icon: "rectangle.and.pencil.and.ellipsis"),
                             MenuItem(id: 4, name: "关于", icon:  "person"),]

struct WubiMacContentView: View {
    @State var columnVisibility: NavigationSplitViewVisibility = .all
    @State var selectionIndex: Int = 0


    @State var searchs: [Wubi] = []
    @State var searchSelectionIndex: String = "0"


    @Query(filter: #Predicate<Wubi> {$0.isFavorite},sort: \Wubi.searchDate,order: .reverse) var favorites: [Wubi]
    @State var favoriteSelectionIndex: String  = "0"

    @State var searchString: String  = ""
    @Query(filter: #Predicate<Wubi> {$0.isSearch},sort: \Wubi.searchDate,order: .reverse) var historys: [Wubi]

    
    @State var histroySelectionIndex: String  = "0"
    var body: some View  {
        NavigationSplitView(columnVisibility: $columnVisibility, sidebar:  {
            List(menuItems,selection: $selectionIndex) { item in
                SideBarLabel(title: item.name, imageName: item.icon)
            }
        }, content: {
            switch selectionIndex {
                case 0: SearchListView(selectionIndex: $searchSelectionIndex, wubis: $searchs)
                case 1: SearchHistoryView(selectionIndex: $histroySelectionIndex, historys: historys)
                case 2: FavoriteListView(selectionIndex: $favoriteSelectionIndex, favorites: favorites)
                case 3: EmptyView()
                default: Text("")
            }
        },  detail: {
            switch selectionIndex {
                case 0:
                    if let wubi = $searchs.first(where: { $0.id == searchSelectionIndex }) {
                        WubiDetailView(wubi:wubi, action: {})
                    } else {
                        EmptyView()
                    }
                case 1:
                    if let wubi = historys.first(where: { $0.id == histroySelectionIndex }) {
                        WubiDetailView(wubi:.constant(wubi), action: {})
                    } else {
                        EmptyView()
                    }
                case 2:
                    if let wubi = favorites.first(where: { $0.id == favoriteSelectionIndex }) {
                        WubiDetailView(wubi:.constant(wubi), action: {})
                    } else {
                        EmptyView()
                    }
                case 3:
                    TypingView()
                default:
                    EmptyView()
            }
        })
        .frame(minWidth: 1250, minHeight: 650)
        .navigationTitle("98五笔")
    }
}

#Preview {
    WubiMacContentView()
}
