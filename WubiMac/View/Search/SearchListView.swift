//
//  SearchListView.swift
//  Wubi
//
//  Created by yongyou on 2023/8/4.
//

import SwiftUI
import SwiftData

struct SearchListView: View {
    @Binding var selectionIndex: String
    @State   var searchString: String = ""
    @EnvironmentObject var state: SearchViewState
    @Environment(\.modelContext) var modelContext
    var body: some View {
        if state.wubis.isEmpty {
            Text("请输入要查找的内容")
                .searchable(text: $searchString,prompt: "查找")
                .onSubmit(of:.search, runSearch)
        } else {
            List(state.wubis, selection: $selectionIndex) { word in
                HStack {
                    Text(word.character)
                        .padding()
                        .foregroundStyle(.green)
                    Text(word.jianma.uppercased() )
                        .padding()
                        .foregroundStyle(.black)
                    Text(word.components.filter { $0 != "〔" && $0 != "〕" && $0 != "※" })
                        .padding()
                        .foregroundStyle(.blue)
                }

            }
            .searchable(text: $searchString,prompt: "查找")
            .onSubmit(of:.search, runSearch)
        }

    }

     func runSearch() {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                state.wubis.removeAll()
            }
            searchString.forEach { word in
                do {
                    let wubi = try Database.shared!.query(keyValue:String(word))
                    DispatchQueue.main.async {
                        state.wubis.append(wubi)
                        modelContext.insert(wubi)
                    }
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
        let state = SearchViewState()
        state.wubis = [previewWord,previewWord]
        return SearchListView(selectionIndex: .constant("0"), searchString: "就把五笔")
            .environmentObject(state)
    }
}

//#Preview {
//    let state = SearchViewState()
//    state.wubis = [previewWord,previewWord]
//    return SearchListView(selectionIndex: .constant("0"), searchString: "就把五笔")
//        .environmentObject(state)
//}
