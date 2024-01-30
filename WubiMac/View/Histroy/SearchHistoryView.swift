//
//  SearchHistoryView.swift
//  WubiMac
//
//  Created by yongyou on 2024/1/3.
//

import SwiftUI
import SwiftData

struct SearchHistoryView: View {
    @Binding var selectionIndex: String
    var historys: [Wubi]

    var body: some View {
        WubiListView(selectionIndex: $selectionIndex, wubis: historys)
    }
}

//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: Wubi.self, configurations: config)
//    for i in 1..<10 {
//        container.mainContext.insert(previewWord)
//    }
//    return SearchHistoryView( selectionIndex: $0)
//        .modelContainer(container)
//}
