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
    let word: String = "" //字
    let pingyin: String = "" //拼音
    
    var components_86  : String = ""  //字根:󰁺󰃙󰄦󰁧
    var jianma_86_1: String = "" //1级简码
    var jianma_86_2: String = "" //2级简码
    var jianma_86_3: String = "" //3级简码
    var quanma_86: String = "" //全码

    var components_98  : String = ""  //字根〔※󰁺※󰃙※󰄦※󰁧※〕
    var jianma_98_1: String = "" //1级简码
    var jianma_98_2: String = "" //2级简码
    var jianma_98_3: String = "" //3级简码
    var quanma_98: String = "" //全码


    var components_gbk  : String = ""  //字根:󰁺󰃙󰄦󰁧
    var jianma_gbk_1: String = "" //1级简码
    var jianma_gbk_2: String = "" //2级简码
    var jianma_gbk_3: String = "" //3级简码
    var quanma_gbk: String = "" //全码


    var isFavorite: Bool = false //是否被收藏
    var isSearch: Bool = false //是否查找过
    let searchDate: Date? //查找时间，用于排序
    let favoriteDate: Date? //收藏时间，用于排序

    
    init(id: UUID = UUID(), word: String, pingyin: String, 
         components_86: String = "", jianma_86_1: String = "", jianma_86_2: String = "", jianma_86_3: String = "", quanma_86: String = "",
         components_98: String = "", jianma_98_1: String = "", jianma_98_2: String = "", jianma_98_3: String = "", quanma_98: String = "",
         components_gbk: String = "", jianma_gbk_1: String = "", jianma_gbk_2: String = "", jianma_gbk_3: String = "", quanma_gbk: String = "",
         isFavorite: Bool = false, isSearch: Bool = false, searchDate: Date = .now, favoriteDate: Date = .now) {
        self.id = id
        self.word = word
        self.pingyin = pingyin
        self.components_86 = components_86
        self.jianma_86_1 = jianma_86_1
        self.jianma_86_2 = jianma_86_2
        self.jianma_86_3 = jianma_86_3
        self.quanma_86 = quanma_86

        self.components_98 = components_98
        self.jianma_98_1 = jianma_98_1
        self.jianma_98_2 = jianma_98_2
        self.jianma_98_3 = jianma_98_3
        self.quanma_98 = quanma_98


        self.components_gbk = components_gbk
        self.jianma_gbk_1 = jianma_gbk_1
        self.jianma_gbk_2 = jianma_gbk_2
        self.jianma_gbk_3 = jianma_gbk_3
        self.quanma_gbk = quanma_gbk

        self.isFavorite = isFavorite
        self.isSearch = isSearch
        self.searchDate = searchDate
        self.favoriteDate = favoriteDate
    }

    

}
