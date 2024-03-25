//
//  Article.swift
//  Wubi
//
//  Created by sakuragi on 2024/3/12.
//

import Foundation
import SwiftData

@Model
class Article: Identifiable {
    
    enum ArticleType: Codable {
        case character //常用字
        case phrase //常用词条
        case article //文章
        case english //英文
        case word //单词
        case customize //自定义
    }
    let id: String = ""
    let name: String = ""
    let type: ArticleType?
    var content: String = ""

    init(id: String, name: String, type: ArticleType, content: String) {
        self.id = id
        self.name = name
        self.type = type
        self.content = content

    }
}
