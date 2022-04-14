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
    var components: String //字根
    var alphabetical: String //简码
    var all_alphabetical: String //全码
    var pingyin: String //拼音
    var alphabeticals: [String] //全码对应的提示键盘图片名字
}
