//
//  WubiListView.swift
//  WubiMac
//
//  Created by yongyou on 2024/1/16.
//

import SwiftUI

struct WubiListView: View {
    @Binding var selectionIndex: String
    var wubis: [Wubi]
    var body: some View {
//        List(0..<1) {_ in
//            HStack {
//                Text("单字")
//                    .frame(width:30)
//                    .foregroundStyle(.red)
//                Text("简码")
//                    .frame(width:40)
//                    .foregroundStyle(.red)
//                Text("拆字")
//                    .frame(width:80)
//                    .foregroundStyle(.red)
//            }
//        }
//        .frame(height: 40)

        List(wubis, selection: $selectionIndex) { word in
            HStack {
                Text(word.character)
                    .font(.system(size: 30))
                    .foregroundStyle(.blue)
                VStack(alignment:.leading) {
                    Text(word.jianma.uppercased() )
                        .font(.title2)
                        .foregroundStyle(.black)
                    Text(word.components.filter { $0 != "〔" && $0 != "〕" && $0 != "※" })
                        .font(.title3)
                        .foregroundStyle(.gray)
                }

            }
        }
    }
}

#Preview {
    WubiListView(selectionIndex: .constant("0"), wubis: [previewWord,previewWord])
}
