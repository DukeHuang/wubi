//
//  View+Exs.swift
//  Wubi
//
//  Created by yongyou on 2023/7/13.
//

import SwiftUI

extension View {
    func swiftyListDivider() -> some View {
        background(Divider().offset(y: 4.0), alignment: .bottom)
    }
}
