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
    case right
    case error
}

final class ContentViewState: ObservableObject {

    @Published var check: Result = .right
    @Published var fiveStroke: FiveStroke = FiveStroke()
    var database = Database()

	func showCountAdd(keyName:String) -> Void {
		
	}

}


