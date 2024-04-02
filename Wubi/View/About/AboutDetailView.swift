//
//  AboutDetailView.swift
//  Wubi
//
//  Created by sakuragi on 2024/4/1.
//

import SwiftUI

struct AboutDetailView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("联系我")
            HStack {
                Image(systemName: "network")
                Link("\(AboutDetailView.offSiteAdr.replacingOccurrences(of: "http://", with: ""))", destination: AboutDetailView.offCiteUrl)
            }
            HStack {
                Image(systemName: "paperplane")
                Link("邮件", destination: AboutDetailView.offEmailUrl)
            }
        }
    }
}

extension AboutDetailView {
    private static var offSiteAdr: String { "http://www.sakuragg.com" }
    private static var offEmail: String { "huangyongyou1989@gmail.com" }

    public static var offCiteUrl: URL { URL(string: AboutDetailView.offSiteAdr )! }
    public static var offEmailUrl: URL { URL(string: "mailto:\(AboutDetailView.offEmail)")! }
}

#Preview {
    AboutDetailView()
}
