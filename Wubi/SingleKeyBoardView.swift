//
//  SingleKeyBoardView.swift
//  Wubi
//
//  Created by yongyou on 2023/7/13.
//

import SwiftUI

struct SingleKeyBoardView: View {
    var quanma: Array<String>
    var body: some View {
        HStack(spacing: 5) {
            ForEach(quanma.indices,id:\.self) { index in
                if let image = KeyboardImageManager.shared.image98Dict[quanma[index].capitalized] {
                    VStack {
                        Image(systemName: "\(quanma[index].capitalized.lowercased()).square.fill")
                            .resizable()
                            .frame(width: 60, height: 60, alignment: .center)
                        Image(nsImage: image)
                            .resizable()
                            .frame(width: 60, height: 60, alignment: .center)

                    }

                }
            }
        }
    }
}

struct SingleKeyBoardView_Previews: PreviewProvider {
    static var previews: some View {
        SingleKeyBoardView(quanma: ["a","b","c"])
    }
}


