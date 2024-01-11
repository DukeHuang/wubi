//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by yongyou on 2023/6/28.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var word: Wubi
    var action: () -> Void
    var body: some View {
        Button {
            do {
                try Database.shared?.update(
                    where: "A_key",
                    equal: word.id,
                    which: "is_Favorite",
                    equal: word.isFavorite ? 0 : 1
                )
            } catch {
                print(error)
            }
            do {
                try word = (Database.shared?.query(keyValue: word.character))!
            }  catch {
                print(error)
            }
            action()
        } label: {
            Label("Toggle Favorite", systemImage: word.isFavorite ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(word.isFavorite ? .yellow : .gray)
        }

    }
}

//struct FavoriteButton_Previews: PreviewProvider {
//    static var previews: some View {
////        关注一下这个方法
//        FavoriteButton(word: .constant(previewWord),db:db)
//    }
//}
