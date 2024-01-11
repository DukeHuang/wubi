//
//  FavoriteViewState.swift
//  Wubi
//
//  Created by yongyou on 2023/7/29.
//

import Foundation
import Combine

class FavoriteViewState: ObservableObject {
    @Published var favoriteWords: [Wubi] = []
    func getFavoriteWords() {
        do {
            favoriteWords = try Database.shared?.queryFavorites() ?? []
        } catch {
            print(error)
        }
    }
}
