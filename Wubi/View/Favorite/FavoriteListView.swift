//
//  FavoriteView.swift
//  Wubi
//
//  Created by yongyou on 2023/7/14.
//

import SwiftUI
import SwiftData

struct FavoriteListView: View {
    @Binding var selectedWubi: Wubi?
    var wubis: [Wubi]
    var scheme: WubiScheme
    var body: some View {
        WubiListView(selected: $selectedWubi, wubis:wubis, scheme: scheme)
    }
}

//struct FavoriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteView(selectionIndex: )
//    }
//}
