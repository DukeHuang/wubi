//
//  TypingTipsView.swift
//  Wubi
//
//  Created by yongyou on 2024/4/11.
//

import SwiftUI
import SwiftData

struct TypingTipsView: View {
    @Binding var wubi: Wubi?
    //    var action: () -> Void
    //    @Binding var settings: UserSetting
    @Query var settings: [UserSetting]
    var body: some View {
        if let wubi = wubi {
            HStack {
                List {
//                    HStack {
//                        Text(wubi.word)
//                            .font(.system(size: 70))
//                        HStack(alignment: .top) {
//                            VStack(alignment:.leading) {
//                                Text(wubi.pingyin)
//                                    .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
//                                    .foregroundStyle(.white)
//                                    .background(.teal)
//                                    .cornerRadius(3)
//                            }
//                            FavoriteButton(word: .constant(wubi))
//                        }
//                    }.listRowSeparator(.hidden,edges: .all)
                    /*
                     Section("拆字:") {
                     QLImage(wubi.character)
                     .frame(width: 280, height: 70, alignment: .leading)
                     }
                     */
//                    if (settings.first?.isShow86 ?? true) {
//                        WubiDetailSection(components: wubi.components_86, jianma_1: wubi.jianma_86_1, jianma_2: wubi.jianma_86_2, jianma_3: wubi.jianma_86_3, quanma: wubi.quanma_86, scheme: .wubi86)
//                        //                            .listSectionSeparator(.visible)
//                    }

                    if (settings.first?.isShow98 ?? true) {
                        WubiDetailSection(components: wubi.components_98.filter({ $0 != "〔" && $0 != "〕" && $0 != "※" }), jianma_1: wubi.jianma_98_1, jianma_2: wubi.jianma_98_2, jianma_3: wubi.jianma_98_3, quanma: wubi.quanma_98, scheme: .wubi98)
                        //                            .listSectionSeparator(.hidden)
                    }
//                    if (settings.first?.isShowgbk ?? true) {
//                        WubiDetailSection(components: wubi.components_gbk, jianma_1: wubi.jianma_gbk_1, jianma_2: wubi.jianma_gbk_2, jianma_3: wubi.jianma_gbk_3, quanma: wubi.quanma_gbk, scheme: .wubigbk)
//                        //                            .listSectionSeparator(.hidden)
//                    }
                }
            }
        }
    }
}

#Preview {
    TypingTipsView(wubi: .constant(previewWord))
}
