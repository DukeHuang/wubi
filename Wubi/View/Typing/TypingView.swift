//
//  TypingView.swift
//  Wubi
//
//  Created by yongyou on 2024/1/15.
//

import SwiftUI

struct Word: Hashable {
    let id: Int
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

public extension View {
    func getSize(size: Binding<CGSize>) -> some View {
        background {
            GeometryReader { reader in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: reader.size)
            }
        }.onPreferenceChange(SizePreferenceKey.self) { newSize in
            size.wrappedValue = newSize
        }
    }
}

struct TypingView: View {
    
    @Binding var article: Article?
    @State var origin: String?
    @State var content: AttributedString?

    @State private var inputText = ""
    @State private var version:Int = 0
    
    @State private var count = 0

    var body: some View {
        VStack (alignment: .leading) {
            ScrollView {
                Text(content ?? "")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
            }.border(.black)
            TextEditor(text: $inputText)
                .font(.largeTitle)
                .border(.black)
                .lineSpacing(10)
        }
        .onChange(of: inputText, { oldValue, newValue in
            self.content = self.compareAndColorize(origin ?? "", with: inputText)
        })
        .onChange(of: article) { oldValue, newValue in
            origin = newValue?.content
            content = AttributedString(newValue?.content ?? "")
            inputText = ""
        }
        .padding()
    }
    func compareAndColorize(_ mutableString:String, with immutableString: String) -> AttributedString {
        
        var result = AttributedString()
        let minLength = min(mutableString.count, immutableString.count)
        let mutableChars = Array(mutableString)
        let immutableChars = Array(immutableString)
        
        for i in 0..<minLength {
            var mutableChar = AttributedString(String(mutableChars[i]))
            if mutableChars[i] == immutableChars[i] {
                // 如果汉字相同，背景颜色变成灰色
                mutableChar.backgroundColor = .gray
            } else {
                // 如果汉字不同，背景颜色变成红色
                mutableChar.backgroundColor = .red
            }
            result.append(mutableChar)
        }
        
        // 如果可变字符串比不可变字符串长，将剩余部分添加为红色
        if mutableString.count > minLength {
            let index = mutableString.index(mutableString.startIndex, offsetBy: minLength)
            let remainingString = AttributedString(String(mutableString[index...]))
            result.append(remainingString)
        }
        
        return result
    }
}

#Preview {
    TypingView(article: .constant(DefaultArticle.love_your_life),
               origin: DefaultArticle.love_your_life.content,
               content: AttributedString(DefaultArticle.love_your_life.content)
    )
}


/*
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
 */
