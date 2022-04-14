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

final class ContentViewState: ObservableObject {

    @Published var check: Result = .correct
    @Published var fiveStroke: FiveStroke = FiveStroke()
    var database = Database()

	func showCountAdd(keyName:String) -> Void {
		
	}

}


