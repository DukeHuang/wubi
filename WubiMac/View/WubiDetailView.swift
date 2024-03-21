//
//  WubiDetailView.swift
//  WubiMac
//
//  Created by yongyou on 2023/8/2.
//

import SwiftUI

struct WubiDetailView: View {
    @Binding var wubi: Wubi?
//    var action: () -> Void
    var body: some View {
        if let wubi = wubi {
            HStack {
                List {
                    HStack {
                        Text(wubi.word)
                            .font(.system(size: 70))
                        HStack(alignment: .top) {
                            VStack(alignment:.leading) {
                                Text(wubi.pingyin)
                                    .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                    .foregroundStyle(.white)
                                    .background(.teal)
                                    .cornerRadius(3)
                            }
                            FavoriteButton(word: .constant(wubi))
                        }
                    }
                    /*
                     Section("拆字:") {
                     QLImage(wubi.character)
                     .frame(width: 280, height: 70, alignment: .leading)
                     }
                     */
                    WubiDetailSection(components: wubi.components_86, jianma_1: wubi.jianma_86_1, jianma_2: wubi.jianma_86_2, jianma_3: wubi.jianma_86_3, quanma: wubi.quanma_86, scheme: .wubi86)
                    WubiDetailSection(components: wubi.components_98.filter({ $0 != "〔" && $0 != "〕" && $0 != "※" }), jianma_1: wubi.jianma_98_1, jianma_2: wubi.jianma_98_2, jianma_3: wubi.jianma_98_3, quanma: wubi.quanma_98, scheme: .wubi98)
                    WubiDetailSection(components: wubi.components_gbk, jianma_1: wubi.jianma_gbk_1, jianma_2: wubi.jianma_gbk_2, jianma_3: wubi.jianma_gbk_3, quanma: wubi.quanma_gbk, scheme: .wubigbk)
                }
            }
        }
    }
}

struct WubiDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WubiDetailView(wubi: .constant(previewWord))
    }
}
