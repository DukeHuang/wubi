//
//  SingleKeyBoardView.swift
//  Wubi
//
//  Created by yongyou on 2023/7/13.
//

import SwiftUI

struct SingleKeyBoardView: View {
    var quanma: Array<String>

    @State var showPoem: Bool = true
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
                        HStack(){
                            Image(nsImage: image)
                                .resizable()
                                .frame(width: 60, height: 60, alignment: .center)
//                            Button {
//                                showPoem.toggle()
//                            } label: {
//                            }
//                            .keyboardShortcut("h")

                        }
                        if showPoem {
                            Text(poem[key] ?? "" )
                                 .foregroundStyle(.gray)
                        }

//
                    }
                    .frame(width: 100)
//                    Spacer().frame(width: 50)
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


