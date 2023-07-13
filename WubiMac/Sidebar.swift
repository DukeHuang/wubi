//
//  Sidebar.swift
//  WubiMac
//
//  Created by yongyou on 2023/7/4.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        List {
            //https://blog.devgenius.io/how-to-use-sf-symbols-in-your-ios-app-ios-swift-guide-2e81ade5f69e
            //how to use sf symbols

        //https://sarunw.com/posts/how-to-toggle-sidebar-in-macos/
            Section {
                NavigationLink {
                    ContentView()
                } label: {
                    SideBarLabel(title: "查找", imageName:"magnifyingglass")
                }
            }

            Section {
                NavigationLink {
                    SearchView()
                } label: {
                    SideBarLabel(title: "练习", imageName:"rectangle.and.pencil.and.ellipsis")
                }
            }

            Section {
                NavigationLink {
                    SearchView()
                } label: {
                    SideBarLabel(title: "统计", imageName:"lines.measurement.horizontal")
                }
            }

            Section {
                NavigationLink {
                    SearchView()
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
                .frame(width: 20)
            Text(title)
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
