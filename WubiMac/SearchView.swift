//
//  ContentView.swift
//  Wubi
//
//  Created by yongyou on 2020/7/14.
//  Copyright © 2020 sakuragi. All rights reserved.
//

import SwiftUI

let previewWord = Wubi(id: "",
                       character: "",
                       components: "",
                       jianma: "",
                       quanma: "",
                       jianmaKeys: [""],
                       quanmaKeys: [""],
                       pingyin: "",
                       isFavorite: false)

struct SearchView: View {
    @State private var searchWord: String = ""
    @State var wubi: Wubi?

    var body: some View {
        if let _ = wubi {
            WubiDetailView(wubi: Binding($wubi)!) {}
            .searchable(text: $searchWord,prompt: "请输入要查询的字")
            .onSubmit(of:.search, runSearch)
        } else {
            Text("请输入要查询的单字")
                .searchable(text: $searchWord,prompt: "请输入要查询的字")
                .onSubmit(of:.search, runSearch)
        }
    }


    private func splitComponents(_ components: String) -> String {
        //〔※󰁺※󰃙※󰄦※󰁧※〕
        return components.filter { $0 != "〔" && $0 != "〕" && $0 != "※" }
    }

    func runSearch() {
        do {
            try self.wubi = Database.shared!.query(keyValue:searchWord)
        } catch {
            //do nothing
            print("search error: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
