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

            Text("\(Bundle.main.appName)")
                .font(.system(size: 20, weight: .bold))
            // Xcode 13.0 beta 2
            //.textSelection(.enabled)

//            Link("\(AboutView.offSiteAdr.replace(of: "http://", to: ""))", destination: AboutView.offCiteUrl )

            Text("Ver: \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild)) ")
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
    private static var offSiteAdr: String { "http://www.taogit.com" }
    private static var offEmail: String { "someUser@gmail.com" }

    public static var offCiteUrl: URL { URL(string: AboutView.offSiteAdr )! }
    public static var offEmailUrl: URL { URL(string: "mailto:\(AboutView.offEmail)")! }
}
extension Bundle {
    public var appName: String { getInfo("CFBundleName")  }
    //public var displayName: String {getInfo("CFBundleDisplayName")}
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
