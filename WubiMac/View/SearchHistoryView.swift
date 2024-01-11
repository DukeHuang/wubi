//
//  SearchHistoryView.swift
//  WubiMac
//
//  Created by yongyou on 2024/1/3.
//

import SwiftUI
import SwiftData

struct SearchHistoryView: View {

    @Query var historys: [Wubi]

    var body: some View {
        List {
            ForEach(historys) { word in
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
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Wubi.self, configurations: config)
    for i in 1..<10 {
        container.mainContext.insert(previewWord)
    }
    return SearchHistoryView()
        .modelContainer(container)
}
