//
//  SingleKeyBoardView.swift
//  Wubi
//
//  Created by yongyou on 2023/7/13.
//

import SwiftUI

struct SingleKeyBoardView: View {

    var quanma: Array<String>
    var scheme: WubiScheme
    @State var showPoem: Bool = false
    var body: some View {
        #if os(macOS)
        var dic: [String: NSImage] = [:]
        #else
        var dic: [String: UIImage] = [:]
        #endif
        var backColor: Color
        switch scheme {
            case .wubi86:
                dic = KeyboardImageManager.shared.image86Dict
                backColor = .clear
            case .wubi98:
                dic = KeyboardImageManager.shared.image98Dict
                backColor = .clear
            case .wubigbk:
                dic = KeyboardImageManager.shared.imagegbkDict
                backColor = .brown
        }
        return HStack(spacing: 5) {
            ForEach(quanma.indices,id:\.self) { index  in
                let key = quanma[index].capitalized.lowercased()
                if let image = dic[key.uppercased()] {
                    VStack {
                        HStack(){
#if os(macOS)
                            Image(nsImage: image)
                                .resizable()
                                .frame(width: 60, height: 60, alignment: .center)
                                .background(backColor)
#else
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 60, height: 60, alignment: .center)
                                .background(backColor)
#endif


                        }
                        if showPoem {
                            Text(poem[key] ?? "" )
                                 .foregroundStyle(.gray)
                        }
                    }
//                    .frame(width: 100)
                }
            }
        }
    }
}

struct SingleKeyBoardView_Previews: PreviewProvider {
    static var previews: some View {
        SingleKeyBoardView(quanma: ["a","b","c"], scheme: .wubi98)
    }
}


