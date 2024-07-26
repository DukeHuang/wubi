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
                    HStack {
                        Text(wubi.word)
                            .font(.system(size: 70))
//                        HStack(alignment: .top) {
//                            VStack(alignment:.leading) {
//                                Text(wubi.pingyin)
//                                    .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
//                                    .foregroundStyle(.white)
//                                    .background(.teal)
//                                    .cornerRadius(3)
//                            }
//                            FavoriteButton(word: .constant(wubi))
                            switch settings.first?.wubiScheme {
                                case .wubi86:
                                    WubiDetailSection(components: wubi.components_86, jianma_1: wubi.jianma_86_1, jianma_2: wubi.jianma_86_2, jianma_3: wubi.jianma_86_3, quanma: wubi.quanma_86, scheme: .wubi86)
                                case .wubi98:
                                    WubiDetailSection(components: wubi.components_98.filter({ $0 != "〔" && $0 != "〕" && $0 != "※" }), jianma_1: wubi.jianma_98_1, jianma_2: wubi.jianma_98_2, jianma_3: wubi.jianma_98_3, quanma: wubi.quanma_98, scheme: .wubi98)
                                case .wubigbk:
                                    WubiDetailSection(components: wubi.components_gbk, jianma_1: wubi.jianma_gbk_1, jianma_2: wubi.jianma_gbk_2, jianma_3: wubi.jianma_gbk_3, quanma: wubi.quanma_gbk, scheme: .wubigbk)
                                case nil:
                                    WubiDetailSection(components: wubi.components_98.filter({ $0 != "〔" && $0 != "〕" && $0 != "※" }), jianma_1: wubi.jianma_98_1, jianma_2: wubi.jianma_98_2, jianma_3: wubi.jianma_98_3, quanma: wubi.quanma_98, scheme: .wubi98)
                            }
                        }
                    }.listRowSeparator(.hidden,edges: .all)
            }
        }
    }
}

#Preview {
    TypingTipsView(wubi: .constant(previewWord))
}
