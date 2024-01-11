//
//  SearchViewState.swift
//  WubiMac
//
//  Created by yongyou on 2023/12/29.
//

import Foundation
import Combine

class SearchViewState: ObservableObject {
    @Published var wubis: [Wubi] = []
}

