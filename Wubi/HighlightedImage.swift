//
//  SwiftUIView.swift
//  Wubi
//
//  Created by yongyou on 2023/7/14.
//

import SwiftUI

let ratio: CGFloat = 600 / 1237
struct HighlightedImage: View {
    var keys: [String]
    private let rect98Dict = KeyboardImageManager.shared.rect98Dict

    var body: some View {

        ZStack(alignment:.topLeading) {
            Image("iWuBi-98-keyboard")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:600)
            

            Rectangle()
                .foregroundColor(.black)
                .frame(width: 600,height: 480 * ratio)
                .opacity(0.5)

            ForEach(keys, id: \.self) { key in
                if let image = KeyboardImageManager.shared.image98Dict[key.capitalized],
                   let rect = rect98Dict[key.capitalized] {
                    Image(nsImage: image)
                        .resizable()
                        .frame(width: rect.width * ratio,
                               height: rect.height * ratio)
                        .offset(CGSize(width: rect.origin.x * ratio, height: rect.origin.y * ratio))
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HighlightedImage(keys: ["A","B","C"])
    }
}


