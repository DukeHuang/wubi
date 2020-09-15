//
//  ContentView.swift
//  Wubi
//
//  Created by yongyou on 2020/7/14.
//  Copyright © 2020 sakuragi. All rights reserved.
//

import SwiftUI

struct KeyEventHandling: NSViewRepresentable {
	var state: ContentViewState
	class KeyView: NSView {
		var state: ContentViewState = ContentViewState()
		override var acceptsFirstResponder: Bool { true }
		override func keyDown(with event: NSEvent) {
			super.keyDown(with: event)
			if state.keyboardName == event.charactersIgnoringModifiers {
				state.randomImageName()
				state.AddShowCount(keyValue: state.imageName)
			} else {
				state.showTips()
				state.AddErrorCount(keyValue: state.imageName)
			}
		}
	}
	
	func makeNSView(context: Context) -> NSView {
		let view = KeyView()
		view.state = self.state
		
		_ = self.state.openDatabase()
		self.state.createTable()
		self.state.insert()
		
		DispatchQueue.main.async { // wait till next event cycle
			view.window?.makeFirstResponder(view)
		}
		return view
	}
	
	func updateNSView(_ nsView: NSView, context: Context) {
	}
}

struct ContentView: View {
	@EnvironmentObject  var state: ContentViewState
	var body: some View {
		NavigationView {
			VStack (alignment: .leading) {
				NavigationLink(destination: AnalysisView()) {
					Text("Show")
				}
				if state.result == "error" {
					Text(state.keyboardName)
						.font(.largeTitle)
						.fontWeight(.bold)
						.frame(maxWidth:.infinity)
						.padding()
				} else {
					Text("")
						.font(.largeTitle)
						.frame(maxWidth:.infinity)
						.padding()
				}
				Image(state.imageName)
					.background(KeyEventHandling(state:state))
					.scaledToFit()
					.frame(width: 500, height: 100, alignment: .center)
				Spacer()
				Image(state.tipsImageName)
					.frame(width: 500, height: 100, alignment: .center)
					.scaledToFit()
				Text(state.song)
					.font(.title)
					.frame(maxWidth:.infinity)
					.padding()
			}.frame(width: 500, height: 500, alignment: .center)
		}
	}
}


struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
