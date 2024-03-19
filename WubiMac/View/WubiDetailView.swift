//
//  WubiDetailView.swift
//  WubiMac
//
//  Created by yongyou on 2023/8/2.
//

import SwiftUI

struct WubiDetailView: View {
    @Binding var wubi: Wubi?
//    var action: () -> Void
    var body: some View {
        if let wubi = wubi {
            HStack {
                List {
                    HStack {
                        Text(wubi.word)
                            .font(.system(size: 70))
                        HStack(alignment: .top) {
                            VStack(alignment:.leading) {
                                Text(wubi.pingyin)
                                    .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                    .foregroundStyle(.white)
                                    .background(.teal)
                                    .cornerRadius(3)
                            }
                            FavoriteButton(word: .constant(wubi))
                        }
                    }
                    
                    /*
                     Section("拆字:") {
                     QLImage(wubi.character)
                     .frame(width: 280, height: 70, alignment: .leading)
                     }
                     */
                    Section("86五笔:") {
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("拆字:")
                                    Text(wubi.components_86)
                                        .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                        .foregroundStyle(.white)
                                        .background(.gray)
                                        .cornerRadius(3)
                                        .font(.custom("gbkWB-2.otf", size: 14,relativeTo: .title3))
                                }
                                HStack {
                                    Text("简码:")
                                    if (wubi.jianma_86_1.count > 0) {
                                        Text(wubi.jianma_86_1)
                                            .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                            .foregroundStyle(.white)
                                            .background(.gray)
                                            .cornerRadius(3)
                                    }
                                    if (wubi.jianma_86_2.count > 0) {
                                        Text(wubi.jianma_86_2)
                                            .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                            .foregroundStyle(.white)
                                            .background(.yellow)
                                            .cornerRadius(3)
                                        
                                    }
                                    if (wubi.jianma_86_3.count > 0) {
                                        Text(wubi.jianma_86_3)
                                            .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                            .foregroundStyle(.white)
                                            .background(.purple)
                                            .cornerRadius(3)
                                        
                                    }
                                    if (wubi.quanma_86.count > 0) {
                                        Text(wubi.quanma_86)
                                            .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                            .foregroundStyle(.white)
                                            .background(.cyan)
                                            .cornerRadius(3)
                                    }
                                }
                            }
                            Spacer()
                            SingleKeyBoardView(quanma:wubi.quanma_86.map {String($0)}, scheme: .wubi86 )
                        }
                    }
                    Section("98五笔:") {
                        
                        HStack {
                            VStack(alignment: .leading){
                                HStack {
                                    Text("拆字:")
                                    Text(wubi.components_98.filter({ $0 != "〔" && $0 != "〕" && $0 != "※" }))
                                        .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                        .foregroundStyle(.white)
                                        .background(.gray)
                                        .cornerRadius(3)
                                        .font(.custom("98WB-2.otf", size: 14,relativeTo: .title3))
                                }
                                HStack {
                                    Text("简码:")
                                    if (wubi.jianma_98_1.count > 0) {
                                        Text(wubi.jianma_98_1)
                                            .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                            .foregroundStyle(.white)
                                            .background(.gray)
                                            .cornerRadius(3)
                                    }
                                    if (wubi.jianma_98_2.count > 0) {
                                        Text(wubi.jianma_98_2)
                                            .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                            .foregroundStyle(.white)
                                            .background(.yellow)
                                            .cornerRadius(3)
                                        
                                    }
                                    if (wubi.jianma_98_3.count > 0) {
                                        Text(wubi.jianma_98_3)
                                            .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                            .foregroundStyle(.white)
                                            .background(.purple)
                                            .cornerRadius(3)
                                        
                                    }
                                    if (wubi.quanma_98.count > 0) {
                                        Text(wubi.quanma_98)
                                            .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                            .foregroundStyle(.white)
                                            .background(.cyan)
                                            .cornerRadius(3)
                                    }
                                    
                                }
                            }
                            Spacer()
                            SingleKeyBoardView(quanma:wubi.quanma_98.map {String($0)}, scheme: .wubi98 )
                        }
                    }
                    
                    Section("新世纪五笔:") {
                        HStack {
                            VStack(alignment: .leading){
                                HStack {
                                    Text("拆字:")
                                    Text(wubi.components_gbk)
                                        .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                        .foregroundStyle(.white)
                                        .background(.gray)
                                        .cornerRadius(3)
                                        .font(.custom("98WB-2.otf", size: 14,relativeTo: .title3))
                                }
                                HStack {
                                    Text("简码:")
                                    if (wubi.jianma_gbk_1.count > 0) {
                                        Text(wubi.jianma_gbk_1)
                                            .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                            .foregroundStyle(.white)
                                            .background(.gray)
                                            .cornerRadius(3)
                                    }
                                    if (wubi.jianma_gbk_2.count > 0) {
                                        Text(wubi.jianma_gbk_2)
                                            .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                            .foregroundStyle(.white)
                                            .background(.yellow)
                                            .cornerRadius(3)
                                        
                                    }
                                    if (wubi.jianma_gbk_3.count > 0) {
                                        Text(wubi.jianma_gbk_3)
                                            .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                            .foregroundStyle(.white)
                                            .background(.purple)
                                            .cornerRadius(3)
                                        
                                    }
                                    if (wubi.quanma_gbk.count > 0) {
                                        Text(wubi.quanma_gbk)
                                            .padding(EdgeInsets(top: 3, leading:10, bottom: 3, trailing: 10))
                                            .foregroundStyle(.white)
                                            .background(.cyan)
                                            .cornerRadius(3)
                                    }
                                    
                                }
                            }
                            Spacer()
                            SingleKeyBoardView(quanma:wubi.quanma_gbk.map {String($0)} , scheme: .wubigbk)
                        }
                    }
                }
            }
        }
    }
}

struct WubiDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WubiDetailView(wubi: .constant(previewWord))
    }
}
