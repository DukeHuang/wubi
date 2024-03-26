//
//  Sidebar.swift
//  Wubi
//
//  Created by yongyou on 2023/7/4.
//

import SwiftUI

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
struct SideBarLabel: View {
    var item: SideBarItem

    var body: some View {
        HStack {
            Image(systemName:item.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.all,4)
                .foregroundColor(.white)
                .background(item.backgroundColor)
                .frame(maxWidth: 20,maxHeight: 20)
                .cornerRadius(5.0)                
            Spacer().frame(width: 10)
            Text(item.name)
        }

//        Label(item.name, systemImage: item.icon)
//        Label(title: { Text(item.name) },
//              icon: { Image(systemName:item.icon)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .padding(.all,4)
//                .foregroundColor(.white)
//                .background(item.backgroundColor)
//                .frame(maxWidth: 20,maxHeight: 20)
//            .cornerRadius(5.0) }
//        )
    }
}

#Preview {
    SideBarLabel(item: .about).frame(width: 300,height: 300)
}


