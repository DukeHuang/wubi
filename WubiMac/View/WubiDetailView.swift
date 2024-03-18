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
        if let wubi = wubi
        {
            
            
            let components_86 = wubi.components[.wubi86]
            
            let components_98 = wubi.components[.wubi98]?.filter({ $0 != "〔" && $0 != "〕" && $0 != "※" })
            
            let components_gbk = wubi.components[.wubi98]?.filter({ $0 != "〔" && $0 != "〕" && $0 != "※" })
            
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
                                Text(components_98 ?? "")
                                    .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                    .foregroundStyle(.white)
                                    .background(.gray)
                                    .cornerRadius(3)
                                    .font(.custom("98WB-2.otf", size: 14,relativeTo: .title3))
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

                    Section("简码:") {
                        SingleKeyBoardView(quanma:wubi.jianma_1[.wubi98]?.map {String($0)} ?? [""])
                    }
                    
                    Section("全码:") {
                        SingleKeyBoardView(quanma:wubi.quanma[.wubi98]?.map {String($0)} ?? [""])
                    }
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
