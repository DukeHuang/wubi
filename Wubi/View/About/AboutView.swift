//
//  AboutView.swift
//  Wubi
//
//  Created by yongyou on 2023/8/21.
//

import Foundation
import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image("AppIcon")
            Text("\(Bundle.main.displayName)")
                .font(.system(size: 20, weight: .bold))
            HStack {
//                Image(systemName: "v.circle.fill")
                Text("v\(Bundle.main.appVersionLong)")
                //(\(Bundle.main.appBuild))
            }
            Text("Copyright © 2024 sakuragi. All Rights Reserved.")
                .font(.system(size: 10, weight: .thin))
                               .multilineTextAlignment(.center)
//            Text(Bundle.main.copyright)
//                .font(.system(size: 10, weight: .thin))
//                .multilineTextAlignment(.center)
        }
        .padding(20)
        .frame(minWidth: 350, minHeight: 300)
    }
}




extension Bundle {
//    public var appName: String { getInfo("CFBundleName")  }
    public var displayName: String {getInfo("CFBundleDisplayName")}
    //public var language: String {getInfo("CFBundleDevelopmentRegion")}
    //public var identifier: String {getInfo("CFBundleIdentifier")}
//    public var copyright: String { getInfo("NSHumanReadableCopyright").replace(of: "\\\\n", to: "\n") }

    public var appBuild: String { getInfo("CFBundleVersion") }
    public var appVersionLong: String { getInfo("CFBundleShortVersionString") }
    //public var appVersionShort: String { getInfo("CFBundleShortVersion") }

    fileprivate func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "⚠️" }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
