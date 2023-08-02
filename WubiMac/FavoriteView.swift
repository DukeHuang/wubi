//
//  FavoriteView.swift
//  Wubi
//
//  Created by yongyou on 2023/7/14.
//

import SwiftUI

struct FavoriteView: View {
    @Binding var selectionIndex: String
    @EnvironmentObject var state: FavoriteViewState
    var body: some View {
        List(state.favoriteWords,selection: $selectionIndex) { word in
            Text(word.character)
        }.onAppear {
            state.getFavoriteWords()
        }
    }
}

//struct FavoriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteView(selectionIndex: )
//    }
//}
