//
//  FiveTypist.swift
//  Wubi
//
//  Created by yongyou on 2021/5/18.
//  Copyright © 2021 sakuragi. All rights reserved.
//

import Foundation


struct FiveTypist: Identifiable {
    var id = UUID()
    var character: String //字
    var components: String  //字根〔※󰁺※󰃙※󰄦※󰁧※〕
    var jianma: String //简码
    var quanma: String //全码
    var jianmaKeys: [String] //简码对应的英文字母
    var quanmaKeys: [String] //全码对应的英文字母
    var pingyin: String //拼音
}
