//
//  WubiDetailView.swift
//  WubiMac
//
//  Created by yongyou on 2023/8/2.
//

import SwiftUI

struct WubiDetailView: View {
    @Binding var result: Wubi
    var action: () -> Void
    var body: some View {
        List {
            HStack {
                Text(result.character)
                    .font(.largeTitle)
                    .bold()
                Text(result.pingyin)
                    .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                    .foregroundStyle(.white)
                    .background(.teal)
                    .cornerRadius(3)
                FavoriteButton(word: $result, action: action)
            }
            Section("拆字:") {
                Text(result.components.filter { $0 != "〔" && $0 != "〕" && $0 != "※" })
                    .font(.title)
            }
            Section("简码:") {
                Text(result.jianma.uppercased())
                SingleKeyBoardView(quanma:result.jianmaKeys)
            }

            Section("全码:") {
                Text(result.quanma.uppercased())
                SingleKeyBoardView(quanma:result.quanmaKeys)
            }
//            HighlightedImage(keys: result.quanmaKeys)
//                .minimumScaleFactor(0.5)
        }
    }
}

//struct WubiDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        WubiDetailView(result: <#Binding<Wubi>#>)
//    }
//}
