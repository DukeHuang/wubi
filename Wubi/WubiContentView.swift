//
//  WubiContentView.swift
//  Wubi
//
//  Created by yongyou on 2024/1/16.
//

import SwiftUI
import SwiftData



struct WubiContentView: View {
#if os(macOS)
    @State var columnVisibility: NavigationSplitViewVisibility = .all
#else
    @State var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
#endif
    @State var selectedSideBarItem: SideBarItem?

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

    //(filter: #Predicate<UserSetting> { $0.},order:.reverse)
    @Query var settings: [UserSetting]

    @Environment(\.modelContext) var modelContext
    @State var userSetting: UserSetting?

    let sideBarItems: [[SideBarItem]] = [ [.search,.history,.favorite],[.typing],[.setting],[.about]]

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
            case .none:
                return .search($selectedSearch)
        }
    }

    var body: some View  {

#if os(macOS)
        NavigationSplitView(columnVisibility: $columnVisibility, sidebar: {
            List(selection: $selectedSideBarItem) {
                ForEach(sideBarItems, id: \.self) { sectionItems in
                    Section {
                        ForEach(sectionItems,id:\.self) { item in
                            SideBarLabel(item: item)
                        }
                    }
                }
            }
        }, content: {
            switch selectedSideBarItem {
                case .search:
                    SearchListView(selected: $selectedSearch, wubis: $searchs, scheme: settings.first?.wubiScheme ?? .wubi98)
                        .navigationTitle("搜索")
                case .history:
                    SearchHistoryView(selected: $selectedHistory, wubis: historys, scheme: settings.first?.wubiScheme ?? .wubi98)
                        .navigationTitle("搜索历史")
                case .favorite:
                    FavoriteListView(selectedWubi: $selectedFavorite, wubis: favorites, scheme: settings.first?.wubiScheme ?? .wubi98)
                        .navigationTitle("收藏")
                case .typing:
                    TypingListView(selected: $selectedArticle, articles: articles)
                case .about:
                    //                    Text("").navigationSplitViewColumnWidth(0)
                    AboutView()
                case .setting:
                    SettingListView(selected:$selectedSettingItem , settingItems: SettingItem.allCases)
                case .none:
                    SearchListView(selected: $selectedSearch, wubis: $searchs, scheme: settings.first?.wubiScheme ?? .wubi98)
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
                                VersionListView(userSetting: self.userSetting)
                            case .typing:
                                AttributedDemoView()
                            case .wubiVersion:
                                VersionSegementView(version: 0)
                            case .none:
                                EmptyView()
                        }

                }
            }
        })
        //        .frame(minWidth: 1250, minHeight: 650)
        .navigationTitle("五笔助手")
        .onAppear {
            if let s = settings.first {
                userSetting = s
            } else {
                userSetting = UserSetting(wubiScheme: .wubi98)
                modelContext.insert(userSetting!)
            }
        }

#else

        NavigationSplitView {
            TabView(selection: $selectedSideBarItem,
                    content:  {
                //                Text("Tab Content 1").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 1")/*@END_MENU_TOKEN@*/ }.tag(1)
                //                Text("Tab Content 2").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 2")/*@END_MENU_TOKEN@*/ }.tag(2)
                
                SearchListView(selected: $selectedSearch, wubis: $searchs, scheme: settings.first?.wubiScheme ?? .wubi98)
                    .navigationTitle("搜索")
                    .tabItem {
                        Label(SideBarItem.search.name, systemImage: SideBarItem.search.icon)
                    }.tag(SideBarItem.search)
                SearchHistoryView(selected: $selectedHistory, wubis: historys, scheme: settings.first?.wubiScheme ?? .wubi98)
                    .navigationTitle("搜索历史")
                    .tabItem {
                        Label(SideBarItem.history.name, systemImage: SideBarItem.history.icon)
                    }.tag(SideBarItem.history)
                FavoriteListView(selectedWubi: $selectedFavorite, wubis: favorites, scheme: settings.first?.wubiScheme ?? .wubi98)
                    .navigationTitle("收藏")
                    .tabItem {
                        Label(SideBarItem.favorite.name, systemImage: SideBarItem.favorite.icon)
                    }.tag(SideBarItem.favorite)
                TypingListView(selected: $selectedArticle, articles: articles)
                    .tabItem {
                        Label(SideBarItem.typing.name, systemImage: SideBarItem.typing.icon)
                    }.tag(SideBarItem.typing)
                AboutView()
                    .tabItem {
                        Label(SideBarItem.about.name, systemImage: SideBarItem.about.icon)
                    }.tag(SideBarItem.about)
                SettingListView(selected:$selectedSettingItem , settingItems: SettingItem.allCases)
                    .tabItem {
                        Label(SideBarItem.setting.name, systemImage: SideBarItem.setting.icon)
                    }.tag(SideBarItem.setting)
            })
        } detail: {
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
                                VersionListView(userSetting: self.userSetting)
                            case .typing:
                                AttributedDemoView()
                            case .wubiVersion:
                                VersionSegementView(version: 0)
                            case .none:
                                EmptyView()
                        }

                }
            }
        }
//        .navigationTitle("五笔助手")
        .onAppear {
            if let s = settings.first {
                userSetting = s
            } else {
                userSetting = UserSetting(wubiScheme: .wubi98)
                modelContext.insert(userSetting!)
            }
        }
#endif
    }
}

#Preview {
    WubiContentView()
}
