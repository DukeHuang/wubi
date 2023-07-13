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
            WubiMacContentView()
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



struct WubiMacContentView: View {
    var body: some View  {
        NavigationSplitView {
            Sidebar()
        } content: {
            Text("wubi")
                .navigationTitle("wubi")
        } detail: {
            
        }
        .frame(minHeight: 650)
        .navigationTitle("五笔反查")
//        .toolbar {
//            ToolbarItem(placement: .navigation) {
//                Button {
//                    toggleSidebar()
//                } label: {
//                    Image(systemName: "sidebar.leading")
//                }
//            }
//        }

    }

    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}
