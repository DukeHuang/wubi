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
            let components = wubi.components.filter({ $0 != "〔" && $0 != "〕" && $0 != "※" })
            HStack {
                List {
                    HStack {
                        Text(wubi.character)
                            .font(.system(size: 70))
                        HStack(alignment: .top) {
                            VStack(alignment:.leading) {
                                Text(wubi.pingyin)
                                    .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                    .foregroundStyle(.white)
                                    .background(.teal)
                                    .cornerRadius(3)
                                Text(components)
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
                        SingleKeyBoardView(quanma:wubi.jianmaKeys)
                        
                    }
                    
                    Section("全码:") {
                        SingleKeyBoardView(quanma:wubi.quanmaKeys)
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
