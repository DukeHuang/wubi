//
//  FavoriteView.swift
//  Wubi
//
//  Created by yongyou on 2023/7/14.
//

import SwiftUI
import SwiftData

struct FavoriteListView: View {
    @Binding var selectionIndex: String
    var favorites: [Wubi]
    var body: some View {
        WubiListView(selectionIndex: $selectionIndex, wubis:favorites )
    }
}

//struct FavoriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteView(selectionIndex: )
//    }
//}
