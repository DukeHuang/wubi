//
//  TypingView.swift
//  WubiMac
//
//  Created by yongyou on 2024/1/15.
//

import SwiftUI

struct TypingView: View {

//    @Binding var article: Article?
    @Binding var origin: String
    @Binding var content: AttributedString
    @State private var inputText = ""
    @State private var wordCount: Int = 0
    @State private var version:Int = 0

    var body: some View {
        VStack {
            HStack {
                HStack {
                    Button {
                    } label: {
                        Text("打乱")
                    }
                    Button {
                        
                    } label: {
                        Text("重打")
                    }
                    Button {
                    } label: {
                        Text("暂停")
                    }
                    Button {
                    } label: {
                        Text("继续")
                    }
                }
                Spacer()
                Text("6/100")
                Text("1/1")
                Spacer()
                Button {
                } label: {
                    Text("文章选择")
                }
                Button {
                } label: {
                    Text("文章自定义")
                }
                Spacer()
                Picker("", selection: $version) {
                    Text("5").tag(0)
                    Text("10").tag(1)
                    Text("15").tag(2)
                    Text("20").tag(2)
                    Text("50").tag(0)
                    Text("100").tag(0)
                    Text("200").tag(0)
                    Text("500").tag(0)
                    Text("全").tag(0)
                }
                .pickerStyle(.segmented)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("极简模式")
                }
            }
            
            Text(content)
                .border(.primary)
                .font(.largeTitle)
                .padding(.top,20)
            ZStack(alignment: .topTrailing) {
                TextEditor(text: $inputText)
                    .border(.primary)
                    .font(.largeTitle)
                    .padding()
                    .padding(.top, 20)
                    .onChange(of: inputText, { oldValue, newValue in
                        //let words = inputText.split { $0 == " " || $0.isNewline }
                        self.wordCount = inputText.count
                        self.content = self.compareAndColorize(origin, with: inputText)
                        
                    })
                Text("\(wordCount) words")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
        }
    }
        
    
    func compareAndColorize(_ mutableString:String, with immutableString: String) -> AttributedString { 
        
        var result = AttributedString()
        let minLength = min(mutableString.count, immutableString.count)
        let mutableChars = Array(mutableString)
        let immutableChars = Array(immutableString)

        for i in 0..<minLength {
            var mutableChar = AttributedString(String(mutableChars[i]))
            if mutableChars[i] == immutableChars[i] {
                // 如果汉字相同，颜色变成灰色
                mutableChar.foregroundColor = .green
            } else {
                // 如果汉字不同，颜色变成红色
                mutableChar.foregroundColor = .red
            }
            result.append(mutableChar)
        }

        // 如果可变字符串比不可变字符串长，将剩余部分添加为红色
        if mutableString.count > minLength {
            let index = mutableString.index(mutableString.startIndex, offsetBy: minLength)
            var remainingString = AttributedString(String(mutableString[index...]))
            remainingString.foregroundColor = .black
            result.append(remainingString)
        }

        return result
    }
}

//#Preview {
//    TypingView()
//}
