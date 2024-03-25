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
    var scheme: WubiScheme
    
    @Environment(\.modelContext) var modelContext
    var body: some View {
        if wubis.isEmpty {
            EmptyView()
                .searchable(text: $searchString,prompt: "查找")
                .onSubmit(of:.search, runSearch)
        } else {
            WubiListView(selected: $selected, wubis: wubis, scheme: scheme)
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
                if let wubi =  Database.shared!.query(word:String(word)) {
                    wubi.isSearch = true
                    DispatchQueue.main.async {
                        wubis.append(wubi)
                        modelContext.insert(wubi)
                    }
                }
               
            }

        }
    }
}

struct SearchListView_Previews: PreviewProvider {

    static var previews: some View {
        return SearchListView(selected: .constant(previewWord), wubis:.constant([previewWord,previewWord]), searchString: "就把五笔", scheme: .wubi98)
    }
}

//#Preview {
//    let state = SearchViewState()
//    state.wubis = [previewWord,previewWord]
//    return SearchListView(selectionIndex: .constant("0"), searchString: "就把五笔")
//        .environmentObject(state)
//}
