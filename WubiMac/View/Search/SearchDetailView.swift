//
//  ContentView.swift
//  Wubi
//
//  Created by yongyou on 2020/7/14.
//  Copyright © 2020 sakuragi. All rights reserved.
//

import SwiftUI

struct SearchDetailView: View {
    @State private var searchWord: String = ""
    @State var wubi: Wubi?

    var body: some View {
        if let _ = wubi {
            WubiDetailView(wubi: Binding($wubi)!) {}
        } else {
            Text("")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       SearchDetailView(wubi: previewWord)
    }
}
