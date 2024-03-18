//
//  FiveTypist.swift
//  Wubi
//
//  Created by yongyou on 2021/5/18.
//  Copyright © 2021 sakuragi. All rights reserved.
//

import Foundation
import SwiftData

@Model
class Wubi: Identifiable {
    var id = UUID()
//    //这里改成数据库中的id
//    let id: String
    let word: String //字
    let pingyin: String //拼音
    
    var components: [WubiScheme: String]  //字根〔※󰁺※󰃙※󰄦※󰁧※〕
    
    var jianma_1: [WubiScheme: String] //1级简码
    var jianma_2: [WubiScheme: String] //2级简码
    var jianma_3: [WubiScheme: String] //3级简码
    var quanma: [WubiScheme: String] //全码
    
    var isFavorite: Bool = false //是否被收藏
    var isSearch: Bool = false //是否查找过
    let searchDate: Date //查找时间，用于排序
    let favoriteDate: Date //收藏时间，用于排序

    
    init(id: UUID = UUID(), word: String, pingyin: String, components: [WubiScheme: String], jianma_1: [WubiScheme: String], jianma_2: [WubiScheme: String], jianma_3: [WubiScheme: String], quanma: [WubiScheme: String], isFavorite: Bool = false, isSearch: Bool = false, searchDate: Date = .now, favoriteDate: Date = .now) {
        self.id = id
        self.word = word
        self.pingyin = pingyin
        self.components = components
        self.jianma_1 = jianma_1
        self.jianma_2 = jianma_2
        self.jianma_3 = jianma_3
        self.quanma = quanma
        self.isFavorite = isFavorite
        self.isSearch = isSearch
        self.searchDate = searchDate
        self.favoriteDate = favoriteDate
    }

    

}
