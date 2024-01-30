//
//  SingleKeyBoardView.swift
//  Wubi
//
//  Created by yongyou on 2023/7/13.
//

import SwiftUI

struct SingleKeyBoardView: View {
    var quanma: Array<String>

    @State var showPoem: Bool = false
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
                        ZStack(alignment:Alignment(horizontal: .trailing, vertical: .bottom)){
                            Image(nsImage: image)
                                .resizable()
                                .frame(width: 60, height: 60, alignment: .center)
                            Button {
                                showPoem.toggle()
                            } label: {
                                Image(systemName:"info")
                                    .frame(width: 5,height: 5)
                            }

                        }
                        if showPoem {
                            Text(poem[key] ?? "" )
                                 .foregroundStyle(.gray)
                        }

//
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


