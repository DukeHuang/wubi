//
//  WubiDetailView.swift
//  WubiMac
//
//  Created by yongyou on 2023/8/2.
//

import SwiftUI

struct WubiDetailView: View {
    @Binding var wubi: Wubi
    var action: () -> Void
    var body: some View {
        HStack {
            List {
                HStack {
                    Text(wubi.character)
                        .font(.largeTitle)
                        .bold()
                    Text(wubi.pingyin)
                        .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                        .foregroundStyle(.white)
                        .background(.teal)
                        .cornerRadius(3)
                    FavoriteButton(word: $wubi, action: action)
                }
                Section("拆字:") {
                    Text(wubi.components.filter { $0 != "〔" && $0 != "〕" && $0 != "※" })
                        .font(.title)
                }
                Section("简码:") {
                    SingleKeyBoardView(quanma:wubi.jianmaKeys)
                }

                Section("全码:") {
                    SingleKeyBoardView(quanma:wubi.quanmaKeys)
                }
            }
            HighlightedImage(keys: wubi.quanmaKeys)
        }
    }
}

//struct WubiDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        WubiDetailView(result: <#Binding<Wubi>#>)
//    }
//}
