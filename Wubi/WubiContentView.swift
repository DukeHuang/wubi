//
//  WubiContentView.swift
//  Wubi
//
//  Created by yongyou on 2024/1/16.
//

import SwiftUI
import SwiftData

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
                "folder.circle"
            case .favorite:
                "star"
            case .typing:
                "keyboard.chevron.compact.down"
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
    
    var backgroundColor: Color {
        switch self {
            case .search:
                .red
            case .history:
                .red
            case .favorite:
                .red
            case .typing:
                .green
            case .about:
                .orange
            case .setting:
                .gray
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

struct WubiContentView: View {
    #if os(macOS)
    @State var columnVisibility: NavigationSplitViewVisibility = .all
    #else
    @State var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    #endif
    @State var selectedSideBarItem: SideBarItem? = .search

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
    }
}

#Preview {
    WubiContentView()
}
