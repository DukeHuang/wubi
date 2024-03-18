//
//  WubiMenuBarDetailView.swift
//  WubiMac
//
//  Created by yongyou on 2023/8/3.
//

import SwiftUI

struct WubiMenuBarDetailView: View {
    @Binding var wubi: Wubi
    var action: () -> Void
    var body: some View {
        List {
            HStack {
                Text(wubi.word)
                    .font(.largeTitle)
                    .bold()
                Text(wubi.pingyin)
                    .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                    .foregroundStyle(.white)
                    .background(.teal)
                    .cornerRadius(3)
                FavoriteButton(word: $wubi)
                Text(wubi.components[.wubi98]?.filter { $0 != "〔" && $0 != "〕" && $0 != "※" } ?? "")
                    .font(.title)
            }
//            Section("简码:\(wubi.jianma.uppercased())") {
//                SingleKeyBoardView(quanma:wubi.jianmaKeys)
//            }
//            Section("全码: \(wubi.quanma.uppercased())") {
//                SingleKeyBoardView(quanma:wubi.quanmaKeys)
//            }
        }
    }
}

struct WubiMenuBarDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WubiMenuBarDetailView(wubi: .constant(previewWord), action: {})
    }
}
