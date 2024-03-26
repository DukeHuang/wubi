//
//  WubiListView.swift
//  Wubi
//
//  Created by yongyou on 2024/1/16.
//

import SwiftUI
import SwiftData

struct WubiListView: View {
    @Binding var selected: Wubi?
    var wubis: [Wubi]
    var scheme: WubiScheme
    @Query var userSettings: [UserSetting]
    var body: some View {
        List(wubis,id:\.self, selection: $selected) { wubi in
            LabeledContent(wubi.word) {
                HStack(alignment:.center) {
                    if (userSettings.first?.wubiScheme == .wubi86) {
                        Text(wubi.quanma_86.uppercased())
                            .font(.system(size: 10))
                            .foregroundStyle(.black)
                        Text(wubi.components_86)
                            .font(.custom("98WB2", size: 10,relativeTo: .title3))
                            .foregroundStyle(.gray)
                    } else if (userSettings.first?.wubiScheme == .wubi98) {
                        Text(wubi.quanma_98.uppercased())
                            .font(.system(size: 10))
                            .foregroundStyle(.black)
                        Text(wubi.components_98.filter { $0 != "〔" && $0 != "〕" && $0 != "※" })
                            .font(.custom("98WB2", size: 10,relativeTo: .title3))
                            .foregroundStyle(.gray)
                    }
                    else if (userSettings.first?.wubiScheme == .wubigbk) {
                        Text(wubi.quanma_gbk.uppercased())
                            .font(.system(size: 10))
                            .foregroundStyle(.black)
                        Text(wubi.components_gbk)
                            .font(.custom("98WB2", size: 10,relativeTo: .title3))
                            .foregroundStyle(.gray)
                    }
                }
            }
        }.onAppear {
            #if os(macOS)
            selected = wubis.first
            #endif
        }
    }
}

#Preview {
    WubiListView(selected: .constant(previewWord), wubis: [previewWord,previewWord1], scheme: .wubi98)
}
