//
//  Favorite.swift
//  Landmarks
//
//  Created by yongyou on 2023/6/28.
//

import Foundation
import SwiftUI

struct Favorite: Hashable, Codable,Identifiable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var isFavorite: Bool

    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}

