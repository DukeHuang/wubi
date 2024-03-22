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
enum SideBarItem: String, Identifiable, CaseIterable {
    case search
    case history
    case favorite
    case typing
    case setting
    case about

    var id: UUID { UUID() }

    var icon: String {
        switch self {
            case .search:
                "magnifyingglass"
            case .history:
                "doc.text.magnifyingglass"
            case .favorite:
                "star"
            case .typing:
                "rectangle.and.pencil.and.ellipsis"
            case .setting:
                "gear"
            case .about:
                "person"

        }
    }

    var name: String {
        switch self {
            case .search:
                "查找"
            case .history:
                "历史"
            case .favorite:
                "收藏"
            case .typing:
                "跟打"
            case .about:
                "关于"
            case .setting:
                "设置"
        }
    }
}
enum DetailItem {
    case search(Binding<Wubi?>)
    case history(Binding<Wubi?>)
    case favorite(Binding<Wubi?>)
    case typing(Binding<Article?>)
    case about
    case setting(SettingItem?)
}

struct WubiMacContentView: View {
    @State var columnVisibility: NavigationSplitViewVisibility = .all
    @State var selectedSideBarItem: SideBarItem = .search

    //search
    @State var selectedSearch: Wubi?
    @State var searchs: [Wubi] = []

    //history
    @State var selectedHistory: Wubi?
    @Query(filter: #Predicate<Wubi> {$0.isSearch},sort: \Wubi.searchDate,order: .reverse) var historys: [Wubi]

    //favorite
    @State var selectedFavorite: Wubi?
    @Query(filter: #Predicate<Wubi> {$0.isFavorite},sort: \Wubi.searchDate,order: .reverse) var favorites: [Wubi]
    
    
    //Typing
    @State var selectedArticle: Article?
    var articles: [Article] = [DefaultArticle.top500,DefaultArticle.mid500,DefaultArticle.tail500]
    
    //UserSetting

    @State var selectedSettingItem: SettingItem?
    @Query var settings: [UserSetting]

    var selectedDetailItem: DetailItem? {
        switch selectedSideBarItem {
            case .search:
                return .search($selectedSearch)
            case .history:
                return .history($selectedHistory)
            case .favorite:
                return .favorite($selectedFavorite)
            case .typing:
                return .typing($selectedArticle)
            case .about:
                return .about
            case .setting:
                return .setting(selectedSettingItem)
        }
    }

    var body: some View  {
        NavigationSplitView(columnVisibility: $columnVisibility, sidebar: {
            List(SideBarItem.allCases,id: \.self, selection: $selectedSideBarItem) { item in
                SideBarLabel(title: item.name, imageName: item.icon)
            }
        }, content: {
            switch selectedSideBarItem {
                case .search: 
                SearchListView(selected: $selectedSearch, wubis: $searchs, scheme: settings.first?.wubiScheme ?? .wubi98)
                case .history:
                SearchHistoryView(selected: $selectedHistory, wubis: historys, scheme: settings.first?.wubiScheme ?? .wubi98)
                case .favorite:
                FavoriteListView(selectedWubi: $selectedFavorite, wubis: favorites, scheme: settings.first?.wubiScheme ?? .wubi98)
                case .typing:
                    TypingListView(selected: $selectedArticle, articles: articles)
                case .about:
                    Text("").navigationSplitViewColumnWidth(0)
                case .setting:
                    SettingListView(selected:$selectedSettingItem , settingItems: SettingItem.allCases)
//                    DatabaseTestView()
            }
        },  detail: {
            if let detailItem = selectedDetailItem {
                switch detailItem {
                    case .search(let wubi):
                        WubiDetailView(wubi:wubi)
                    case .history(let wubi):
                        WubiDetailView(wubi:wubi)
                    case .favorite(let wubi):
                        WubiDetailView(wubi:wubi)
                    case .typing(let article):
                        TypingView(article: article)
                    case .about:
                        AboutView()
                    case .setting(let settingItem):
                        switch settingItem {
                            case .showWubiVersion:
                                VersionSegementView(version: 0)
                            case .typing:
                                AttributedDemoView()
                            case .wubiVersion:
                                VersionListView()
                            case .none:
                                EmptyView()
                        }

                }
            }
        })
        .frame(minWidth: 1250, minHeight: 650)
        .navigationTitle("98五笔")
    }
}

#Preview {
    WubiMacContentView()
}
