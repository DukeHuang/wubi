//
//  WubiListView.swift
//  WubiMac
//
//  Created by yongyou on 2024/1/16.
//

import SwiftUI

struct WubiListView: View {
    @Binding var selected: Wubi?
    var wubis: [Wubi]
    var scheme: WubiScheme
    var body: some View {
        List(wubis,id:\.self, selection: $selected) { word in
            HStack {
                Text(word.word)
                    .font(.system(size: 15))
                    .foregroundStyle(.blue)
                VStack(alignment:.leading) {
//                    Text((word.jianma_1.first?.values.first?.uppercased() ?? ""))
                    Text(word.quanma[scheme]?.uppercased() ?? "")
                        .font(.system(size: 10))
                        .foregroundStyle(.black)
                    Text((word.components[.wubi98]?.filter { $0 != "〔" && $0 != "〕" && $0 != "※" }) ?? "")
                        .font(.custom("98WB-2.otf", size: 10,relativeTo: .title3))
                        .foregroundStyle(.gray)
                }

            }
        }.onAppear {
            selected = wubis.first
        }
    }
}

#Preview {
    WubiListView(selected: .constant(previewWord), wubis: [previewWord,previewWord1], scheme: .wubi98)
}
