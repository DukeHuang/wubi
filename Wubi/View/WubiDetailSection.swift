//
//  WubiDetailSection.swift
//  Wubi
//
//  Created by sakuragi on 2024/3/19.
//

import SwiftUI

struct WubiDetailSection: View {
    var components: String
    var jianma_1: String
    var jianma_2: String
    var jianma_3: String
    var quanma: String
    var scheme: WubiScheme

    var body: some View {
        
        var title = ""
        switch scheme {
        case .wubi86:
            title = "86五笔"
        case .wubi98:
            title = "98五笔"
        case .wubigbk:
            title = "新世纪五笔"
        }
        return Section(title) {

            #if os(macOS)
            HStack {
                VStack(alignment: .leading){
                    HStack {
                        Text("拆字:")
                        Text(components)
                            .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                            .foregroundStyle(.white)
                            .background(.gray)
                            .cornerRadius(3)
                            .font(.custom("98WB-2.otf", size: 14,relativeTo: .title3))
                    }
                    HStack {
                        Text("简码:")
                        if (jianma_1.count > 0) {
                            Text(jianma_1.uppercased())
                                .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                .foregroundStyle(.white)
                                .background(.gray)
                                .cornerRadius(3)
                        }
                        if (jianma_2.count > 0) {
                            Text(jianma_2.uppercased())
                                .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                .foregroundStyle(.white)
                                .background(.yellow)
                                .cornerRadius(3)
                            
                        }
                        if (jianma_3.count > 0) {
                            Text(jianma_3.uppercased())
                                .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                .foregroundStyle(.white)
                                .background(.purple)
                                .cornerRadius(3)
                            
                        }
                        if (quanma.count > 0) {
                            Text(quanma.uppercased())
                                .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                .foregroundStyle(.white)
                                .background(.cyan)
                                .cornerRadius(3)
                        }
                        
                    }
                }.frame(width: 250,alignment: .leading)
                SingleKeyBoardView(quanma:quanma.map {String($0)} , scheme: scheme)
            }


#else

                VStack(alignment: .leading){
                    HStack {
                        Text("拆字:")
                        Text(components)
                            .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                            .foregroundStyle(.white)
                            .background(.gray)
                            .cornerRadius(3)
                            .font(.custom("98WB-2.otf", size: 14,relativeTo: .title3))
                    }
                    HStack {
                        Text("简码:")
                        if (jianma_1.count > 0) {
                            Text(jianma_1.uppercased())
                                .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                .foregroundStyle(.white)
                                .background(.gray)
                                .cornerRadius(3)
                        }
                        if (jianma_2.count > 0) {
                            Text(jianma_2.uppercased())
                                .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                .foregroundStyle(.white)
                                .background(.yellow)
                                .cornerRadius(3)

                        }
                        if (jianma_3.count > 0) {
                            Text(jianma_3.uppercased())
                                .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                .foregroundStyle(.white)
                                .background(.purple)
                                .cornerRadius(3)

                        }
                        if (quanma.count > 0) {
                            Text(quanma.uppercased())
                                .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                .foregroundStyle(.white)
                                .background(.cyan)
                                .cornerRadius(3)
                        }

                    }

                    SingleKeyBoardView(quanma:quanma.map {String($0)} , scheme: scheme)
                }

#endif
        }
    }
}

//#Preview {
//    WubiDetailSection()
//}
