//
//  ContentViewState.swift
//  Wubi
//
//  Created by yongyou on 2020/7/15.
//  Copyright © 2020 sakuragi. All rights reserved.
//

import SwiftUI
import Combine

enum Result: String {
    case correct
    case error
}

class ContentViewState: ObservableObject {

//    @Published var check: Result = .correct
//    @Published var fiveStroke: FiveStroke = FiveStroke()//@Published是一个属性包装器，被他包装过的属性，就会在用到地方被监听值的变化

    var database = Database()

}


