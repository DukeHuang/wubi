//
//  FiveTypist.swift
//  Wubi
//
//  Created by yongyou on 2021/5/18.
//  Copyright © 2021 sakuragi. All rights reserved.
//

import Foundation


struct Wubi: Identifiable, Codable {
//    var id = UUID()
    //这里改成数据库中的id
    let id: String
    let character: String //字
    let components: String  //字根〔※󰁺※󰃙※󰄦※󰁧※〕
    let jianma: String //简码
    let quanma: String //全码
    let jianmaKeys: [String] //简码对应的英文字母
    let quanmaKeys: [String] //全码对应的英文字母
    let pingyin: String //拼音
    let isFavorite: Bool
}
