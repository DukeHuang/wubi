//
//  KeyboardImageManager.swift
//  Wubi
//
//  Created by yongyou on 2022/10/11.
//  Copyright © 2022 sakuragi. All rights reserved.
//

#if os(macOS)
import AppKit
class KeyboardImageManager: NSObject {
    static let shared = KeyboardImageManager()

    private override init() {
        super.init()
    }

    func trim(image: NSImage, rect: CGRect) -> NSImage {
        let result = NSImage(size: rect.size)
        result.lockFocus()

        let destRect = CGRect(origin: .zero, size: rect.size)
        image.draw(in: destRect, from: rect, operation: .copy, fraction: 1.0)

        result.unlockFocus()
        return result
    }

    public lazy var image98Dict : Dictionary<String, NSImage> = {
        var dict = Dictionary<String, NSImage>()
        let image = NSImage.init(named: "iWuBi-98-keyboard")
        let image98Keys = [
            "Q": [0, 83], "W": [124, 83], "E": [249, 83], "R": [374, 83], "T": [499, 83], "Y": [626, 83], "U": [750, 83], "I": [875, 83], "O": [1000, 83], "P": [1125, 83],
            "A": [35, 222], "S": [160, 222], "D": [285, 222], "F": [410, 222], "G": [535, 222], "H": [661, 222], "J": [786, 222], "K": [911, 222], "L": [1036, 222],
            "Z": [96, 360], "X": [221, 360], "C": [346, 360], "V": [471, 360], "B": [595, 360], "N": [720, 360], "M": [847, 360]
        ]
        for (key, value) in image98Keys {
            let rect = NSRect(x: value[0], y: value[1], width: 113, height: 121)
            dict[key] = image?.cropping(to: rect)
        }
        return dict
    }()
}


#elseif os(iOS)
import UIKit
class KeyboardImageManager: NSObject {
    static let shared = KeyboardImageManager()

    private override init() {
        super.init()
    }

    public lazy var image98Dict : Dictionary<String, UIImage> = {
        var dict = Dictionary<String, UIImage>()
        let image = UIImage.init(named: "iWuBi-98-keyboard")
        let image98Keys = [
            "Q": [0, 83], "W": [124, 83], "E": [249, 83], "R": [374, 83], "T": [499, 83], "Y": [626, 83], "U": [750, 83], "I": [875, 83], "O": [1000, 83], "P": [1125, 83],
            "A": [35, 222], "S": [160, 222], "D": [285, 222], "F": [410, 222], "G": [535, 222], "H": [661, 222], "J": [786, 222], "K": [911, 222], "L": [1036, 222],
            "Z": [96, 360], "X": [221, 360], "C": [346, 360], "V": [471, 360], "B": [595, 360], "N": [720, 360], "M": [847, 360]
        ]
        for (key, value) in image98Keys {
            let rect = CGRect(x: value[0], y: value[1], width: 113, height: 121)
            let cgImageCorpped = image?.cgImage?.cropping(to: rect)
            let imageCorpped = UIImage(cgImage: cgImageCorpped!)
            dict[key] = imageCorpped
        }
        return dict
    }()
}
#endif




