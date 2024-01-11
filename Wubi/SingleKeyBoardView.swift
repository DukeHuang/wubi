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
            ForEach(quanma.indices,id:\.self) { index  in
                let key = quanma[index].capitalized.lowercased()
                if let image = KeyboardImageManager.shared.image98Dict[key.uppercased()] {
                    VStack {
//                        Image(systemName: "\(key).square.fill")
//                            .resizable()
//                            .frame(width: 60, height: 60, alignment: .center)
//                            .foregroundStyle(.gray)
                        Image(nsImage: image)
                            .resizable()
                            .frame(width: 60, height: 60, alignment: .center)
//                        Text(Wubi.poem[key] ?? "" )
//                            .foregroundStyle(.gray)
                    }
                    Spacer().frame(width: 20)
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


