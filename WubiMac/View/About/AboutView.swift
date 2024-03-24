//
//  AboutView.swift
//  WubiMac
//
//  Created by yongyou on 2023/8/21.
//

import Foundation
import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(nsImage: NSImage(named: "AppIcon")!)

            Text("\(Bundle.main.displayName)")
                .font(.system(size: 20, weight: .bold))
            // Xcode 13.0 beta 2
            //.textSelection(.enabled)

            HStack {
                Image(systemName: "network")
                Link("\(AboutView.offSiteAdr.replacingOccurrences(of: "http://", with: ""))", destination: AboutView.offCiteUrl)
            }
            
            
            HStack {
                Image(systemName: "paperplane")
                Link("邮件", destination: AboutView.offEmailUrl)
            }
            

            HStack {
                Image(systemName: "v.circle.fill")
                Text("\(Bundle.main.appVersionLong)")
                //(\(Bundle.main.appBuild))
            }
            
            
            Text("Copyright © 2024 sakuragi. All Rights Reserved.")
                .font(.system(size: 10, weight: .thin))
                               .multilineTextAlignment(.center)
            // Xcode 13.0 beta 2
            //.textSelection(.enabled)

//            Text(Bundle.main.copyright)
//                .font(.system(size: 10, weight: .thin))
//                .multilineTextAlignment(.center)
        }
        .padding(20)
        .frame(minWidth: 350, minHeight: 300)
    }
}

///////////////////////////////////
/// HELPERS
//////////////////////////////////
//class AppDelegate: NSObject, NSApplicationDelegate {
//    private var aboutBoxWindowController: NSWindowController?
//
//    func showAboutWnd() {
//        if aboutBoxWindowController == nil {
//            let styleMask: NSWindow.StyleMask = [.closable, .miniaturizable,/* .resizable,*/ .titled]
//            let window = NSWindow()
//            window.styleMask = styleMask
//            window.title = "About \(Bundle.main.appName)"
//            window.contentView = NSHostingView(rootView: AboutView())
//            window.center()
//            aboutBoxWindowController = NSWindowController(window: window)
//        }
//
//        aboutBoxWindowController?.showWindow(aboutBoxWindowController?.window)
//    }
//}

extension AboutView {
    private static var offSiteAdr: String { "http://www.sakuragg.com" }
    private static var offEmail: String { "huangyongyou1989@gmail.com" }

    public static var offCiteUrl: URL { URL(string: AboutView.offSiteAdr )! }
    public static var offEmailUrl: URL { URL(string: "mailto:\(AboutView.offEmail)")! }
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
