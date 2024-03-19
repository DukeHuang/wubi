//
//  SearchHistoryView.swift
//  WubiMac
//
//  Created by yongyou on 2024/1/3.
//

import SwiftUI
import SwiftData

struct SearchHistoryView: View {
    @Binding var selected: Wubi?
    var wubis: [Wubi]
    var scheme: WubiScheme

    var body: some View {
        WubiListView(selected: $selected, wubis: wubis, scheme: scheme)
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
