//
//  WubiListView.swift
//  WubiMac
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
        List(wubis,id:\.self, selection: $selected) { word in
            HStack {
                Text(word.word)
                    .font(.system(size: 15))
                    .foregroundStyle(.blue)
                VStack(alignment:.leading) {
                    
                    if (userSettings.first?.wubiScheme == .wubi86) {
                        Text(word.quanma_86.uppercased())
                            .font(.system(size: 10))
                            .foregroundStyle(.black)
                        Text(word.components_86)
                            .font(.custom("98WB-2.otf", size: 10,relativeTo: .title3))
                            .foregroundStyle(.gray)
                    } else if (userSettings.first?.wubiScheme == .wubi98) {
                        Text(word.quanma_98.uppercased())
                            .font(.system(size: 10))
                            .foregroundStyle(.black)
                        Text(word.components_98.filter { $0 != "〔" && $0 != "〕" && $0 != "※" })
                            .font(.custom("98WB-2.otf", size: 10,relativeTo: .title3))
                            .foregroundStyle(.gray)
                    }
                    else if (userSettings.first?.wubiScheme == .wubigbk) {
                        Text(word.quanma_gbk.uppercased())
                            .font(.system(size: 10))
                            .foregroundStyle(.black)
                        Text(word.components_gbk)
                            .font(.custom("98WB-2.otf", size: 10,relativeTo: .title3))
                            .foregroundStyle(.gray)
                    }
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
