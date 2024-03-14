//
//  SearchListView.swift
//  Wubi
//
//  Created by yongyou on 2023/8/4.
//

import SwiftUI
import SwiftData

struct SearchListView: View {
    @Binding var selected: Wubi?
    @Binding var wubis: [Wubi]
    @State   var searchString: String = ""
    
    @Environment(\.modelContext) var modelContext
    var body: some View {
        if wubis.isEmpty {
            Text("请输入要查找的内容")
                .searchable(text: $searchString,prompt: "查找")
                .onSubmit(of:.search, runSearch)
        } else {
            WubiListView(selected: $selected, wubis: wubis)
                .searchable(text: $searchString,prompt: "查找")
                .onSubmit(of:.search, runSearch)
        }

    }

    func runSearch() {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                wubis.removeAll()
            }
            searchString.forEach { word in
                do {
                    let wubi = try Database.shared!.query(keyValue:String(word))
                    wubi.isSearch = true
                    wubi.sourceType.insert(.search)
                    DispatchQueue.main.async {
                        wubis.append(wubi)
                        modelContext.insert(wubi)
                    }

                    Database.shared?.insertData()
                } catch {
                    //do nothing
                    print("search error: \(error)")
                }
            }

        }
    }
}

struct SearchListView_Previews: PreviewProvider {

    static var previews: some View {
        return SearchListView(selected: .constant(previewWord), wubis:.constant([previewWord,previewWord]), searchString: "就把五笔")
    }
}

//#Preview {
//    let state = SearchViewState()
//    state.wubis = [previewWord,previewWord]
//    return SearchListView(selectionIndex: .constant("0"), searchString: "就把五笔")
//        .environmentObject(state)
//}
