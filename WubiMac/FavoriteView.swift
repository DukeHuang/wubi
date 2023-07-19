//
//  FavoriteView.swift
//  Wubi
//
//  Created by yongyou on 2023/7/14.
//

import SwiftUI

struct FavoriteView: View {

    @EnvironmentObject var modelData: ModelData
    var body: some View {
        List {
            ForEach(modelData.words) { word in
                NavigationLink {

                } label: {
                    Text(word.character)
                }

            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
