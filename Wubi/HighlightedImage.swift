//
//  SwiftUIView.swift
//  Wubi
//
//  Created by yongyou on 2023/7/14.
//

import SwiftUI

struct HighlightedImage: View {
    var keys: [String]
    private let rect98Dict = KeyboardImageManager.shared.rect98Dict

    var body: some View {

        ZStack(alignment:.topLeading) {
            Image("iWuBi-98-keyboard")

            Rectangle()
                .foregroundColor(.black)
                .opacity(0.5)

            ForEach(keys,id: \.self) { key in
                if let image = KeyboardImageManager.shared.image98Dict[key.capitalized] {
                    Image(nsImage:image)
                        .frame(width: rect98Dict[key.capitalized]?.width,height: rect98Dict[key.capitalized]?.height)
                        .offset(CGSize(width: rect98Dict[key.capitalized]?.origin.x ?? 0, height: rect98Dict[key.capitalized]?.origin.y ?? 0))
                        .foregroundColor(.white)
                        .animation(.default,value: 2)
                }

            }
        }
        .transition(.slide)

    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightedImage(keys: ["A","B","C"])
    }
}


