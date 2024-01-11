//
//  Sidebar.swift
//  WubiMac
//
//  Created by yongyou on 2023/7/4.
//

import SwiftUI

struct Sidebar: View {
    @State var favorites: [Wubi]
    @State var selectedIndex: Int

    var body: some View {

        //https://blog.devgenius.io/how-to-use-sf-symbols-in-your-ios-app-ios-swift-guide-2e81ade5f69e
        //how to use sf symbols
        //https://sarunw.com/posts/how-to-toggle-sidebar-in-macos/
        List {
            Section {
                NavigationLink {
                    SearchDetailView()
                } label: {
                    SideBarLabel(title: "查找", imageName:"magnifyingglass")
                }
            }

            Section {
                NavigationLink {
//                    FavoriteView(state: FavoriteViewState(), selectionIndex: $selectedIndex)
                } label: {//rectangle.and.pencil.and.ellipsis
                    SideBarLabel(title: "收藏", imageName:"star")
                }
            }

            Section {
                NavigationLink {

                } label: {
                    SideBarLabel(title: "统计", imageName:"lines.measurement.horizontal")
                }
            }

            Section {
                NavigationLink {

                } label: {
                    SideBarLabel(title: "设置", imageName:"gear")
                }
            }
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 160)
        .toolbar {
            ToolbarItem {
                Menu {
                    Text("五笔版本")
                } label: {
                    Label("Label", systemImage: "slider.horizontal.3")
                }
            }
        }
    }
}

struct SideBarLabel: View {
    var title: String
    var imageName: String

    var body: some View {
        HStack {
            Image(systemName:imageName)
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 15)
                .foregroundColor(.blue)
            Spacer().frame(width: 10)
            Text(title)
        }.frame(height: 44)
    }
}

//struct Sidebar_Previews: PreviewProvider {
//    static var previews: some View {
//        Sidebar(searchWord: "", favorites: [])
//    }
//}
