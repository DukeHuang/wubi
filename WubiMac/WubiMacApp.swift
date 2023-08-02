//
//  WubiMacApp.swift
//  WubiMac
//
//  Created by yongyou on 2023/7/3.
//

import SwiftUI

@main
struct WubiMacApp: App {
    @State var currentNumber: String = "1"

    var body: some Scene {
        WindowGroup {
           //ContentView()
            WubiMacContentView(columnVisibility: .all, selectionIndex: 0, favoriteSelectionIndex: "0")
        }

        //https://sarunw.com/posts/swiftui-menu-bar-app/
        //how to create a menu bar app
        MenuBarExtra(currentNumber, systemImage: "\(currentNumber).circle") {
            Button("One") {
                currentNumber = "1"
            }
            .keyboardShortcut("1")

            Button("Two") {
                currentNumber = "2"
            }
            .keyboardShortcut("2")

            Button("Three") {
                currentNumber = "3"
            }
            .keyboardShortcut("3")

            Divider()

            Button("Quit") {

                NSApplication.shared.terminate(nil)

            }.keyboardShortcut("q")
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
    var body: some View  {
        NavigationSplitView(columnVisibility: $columnVisibility, sidebar:  {
            List(menuItems,selection: $selectionIndex) { item in
                SideBarLabel(title: item.name, imageName: item.icon)
            }
        }, content: {
            if selectionIndex == 0 {
                Text("Search History")
            }
             if selectionIndex == 1 {
                FavoriteView(selectionIndex: $favoriteSelectionIndex)
                    .environmentObject(favoriteState)
            }
        },  detail: {
            if selectionIndex == 0 {
                SearchView()
            } else if selectionIndex == 1 && favoriteState.favoriteWords.count > 0 {
                WubiDetailView(result:$favoriteState.favoriteWords.first(where: {
                    $0.id == favoriteSelectionIndex }) ?? $favoriteState.favoriteWords.first!,
                               action: {
                    favoriteState.getFavoriteWords()
                    }
                )
            }
        })
        .frame(minHeight: 650)
        .navigationTitle("五笔反查")
    }
}
