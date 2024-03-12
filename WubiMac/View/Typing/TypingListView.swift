//
//  TypingListView.swift
//  WubiMac
//
//  Created by sakuragi on 2024/3/12.
//

import SwiftUI

struct TypingListView: View {
    @Binding var selected: Article
    var articles: [Article]
    var body: some View {
        List(articles,id: \.self, selection: $selected) { article in
            VStack(alignment: .leading, content: {
                Text(article.id)
                    .font(.headline)
                    .foregroundStyle(.black)
                Text(article.content)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            })
        }
    }
}

#Preview {
    TypingListView(selected: .constant(DefaultArticle.mid500), articles: [DefaultArticle.mid500,DefaultArticle.top500,DefaultArticle.tail500])
}
