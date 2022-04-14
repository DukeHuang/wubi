//
//  AppDelegate.swift
//  Wubi
//
//  Created by yongyou on 2020/7/14.
//  Copyright © 2020 sakuragi. All rights reserved.
//


import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	var window: NSWindow!
	@ObservedObject var state = ContentViewState()

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Create the SwiftUI view that provides the window contents.
		let contentView = ContentView()

		// Create the window and set the content view.

        /*
         *A single NSWindow object corresponds to at most one onscreen window. The two principal functions of a window are to provide an area in which views can be placed and to accept and distribute, to the appropriate views, events the user instigates through actions with the mouse and keyboard.
         *一个NSWindow对象最多对应于一个屏幕上的窗口。窗口的两个主要功能是提供一个可以放置视图的区域，以及接受并将用户通过鼠标和键盘的操作而引发的事件分配给相应的视图。
         */

        /*
         convenience init(contentRect: NSRect,
         styleMask style: NSWindow.StyleMask,
         backing backingStoreType: NSWindow.BackingStoreType,
         defer flag: Bool,
         screen: NSScreen?)

         contentRect
         Origin and size of the window’s content area in screen coordinates. The origin is relative to the origin of the provided screen. Note that the window server limits window position coordinates to ±16,000 and sizes to 10,000.
         style
         The window’s style. It can be NSBorderlessWindowMask, or it can contain any of the options described in NSWindow.StyleMask, combined using the C bitwise OR operator. Borderless windows display none of the usual peripheral elements and are generally useful only for display or caching purposes; you should not usually need to create them. Also, note that a window’s style mask should include NSTitledWindowMask if it includes any of the others.
         backingStoreType
         Specifies how the drawing done in the window is buffered by the window device; possible values are described in NSWindow.BackingStoreType.
         flag
         Specifies whether the window server creates a window device for the window immediately. When true, the window server defers creating the window device until the window is moved onscreen. All display messages sent to the window or its views are postponed until the window is created, just before it’s moved onscreen.
         screen
         Specifies the screen on which the window is positioned. The content rectangle is positioned relative to the bottom-left corner of screen. When nil, the content rectangle is positioned relative to (0, 0), which is the origin of the primary screen.
         内容区域
         窗口内容区域的原点和尺寸，以屏幕坐标表示。原点是相对于所提供的屏幕的原点而言的。注意，窗口服务器将窗口位置坐标限制在±16,000，大小限制在10,000。
         样式
         窗口的样式。它可以是NSBlessWindowMask，也可以包含NSWindow.StyleMask中描述的任何选项，用C语言的bitwise OR操作符组合。无边界窗口不显示通常的外围元素，通常只对显示或缓存有用；你通常不应该需要创建它们。另外，请注意，一个窗口的样式掩码如果包括任何其他的，应该包括NSTitledWindowMask。
         支持存储类型（backingStoreType
         指定窗口设备如何缓冲在窗口中完成的绘图；可能的值在NSWindow.BackingStoreType中描述。
         标志
         指定窗口服务器是否立即为该窗口创建一个窗口设备。当为真时，窗口服务器会推迟创建窗口设备，直到窗口在屏幕上被移动。所有发送到该窗口或其视图的显示信息都会被推迟，直到窗口被创建，就在它被移到屏幕上之前。
         屏幕
         指定窗口所处的屏幕。内容矩形是相对于屏幕的左下角定位的。当nil时，内容矩形相对于（0，0）定位，这是主屏幕的原点。
         */
		window = NSWindow(
		    contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
		    styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
		    backing: .buffered, defer: false)
        /*
         The window is placed exactly in the center horizontally and somewhat above center vertically. Such a placement carries a certain visual immediacy and importance. This method doesn’t put the window onscreen, however; use makeKeyAndOrderFront(_:) to do that.
         You typically use this method to place a window—most likely an alert dialog—where the user can’t miss it. This method is invoked automatically when a panel is placed on the screen by the runModal(for:) method of the NSApplication class.
         窗户在水平方向上正好位于中心位置，在垂直方向上略高于中心位置。这样的位置带有某种视觉上的直接性和重要性。然而，这个方法并没有把窗口放在屏幕上；使用makeKeyAndOrderFront(_:)来做这个。
         你通常使用这个方法来放置一个窗口--很可能是一个警报对话框--在用户不能错过它的地方。当一个面板被NSApplication类的runModal(for:)方法放置在屏幕上时，这个方法会被自动调用。
         */
		window.center()
		window.setFrameAutosaveName("Main Window")
        /*
         *  An AppKit view that hosts a SwiftUI view hierarchy.
         *  一个承载SwiftUI视图层次结构的AppKit视图。
         *  You use NSHostingView objects to integrate SwiftUI views into your AppKit view hierarchies. A hosting view is an NSView object that manages a single SwiftUI view, which may itself contain other SwiftUI views. Because it is an NSView object, you can integrate it into your existing AppKit view hierarchies to implement portions of your UI. For example, you can use a hosting view to implement a custom control.
         A hosting view acts as a bridge between your SwiftUI views and your AppKit interface. During layout, the hosting view reports the content size preferences of your SwiftUI views back to the AppKit layout system so that it can size the view appropriately. The hosting view also coordinates event delivery.

         *  您使用 NSHostingView 对象将 SwiftUI 视图集成到您的 AppKit 视图层次中。托管视图是一个管理单个SwiftUI视图的NSView对象，它本身可能包含其他SwiftUI视图。因为它是一个 NSView 对象，所以你可以将它整合到你现有的 AppKit 视图层次结构中，以实现你的 UI 的一部分。例如，你可以使用一个托管视图来实现一个自定义控件。
         托管视图在你的SwiftUI视图和你的AppKit界面之间起到了桥梁作用。在布局过程中，托管视图将你的 SwiftUI 视图的内容大小偏好报告给 AppKit 布局系统，以便它能够适当地调整视图的大小。托管视图还负责协调事件交付。
         *
         * Supplies an ObservableObject to a view subhierarchy
         * 为一个视图子层次提供一个ObservableObject。
         */
		window.contentView = NSHostingView(rootView: contentView.environmentObject(state))
        //class NSHostingView<Content> where Content : View
        //func environmentObject<T>(_ object: T) -> some View where T : ObservableObject

        /* func makeKeyAndOrderFront(_ sender: Any?)
         * Moves the window to the front of the screen list, within its level, and makes it the key window; that is, it shows the window.
         * 将窗口移到屏幕列表的前面，在其水平范围内，并使其成为关键窗口；也就是说，它显示了该窗口。
         */
		window.makeKeyAndOrderFront(nil)
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}


}

