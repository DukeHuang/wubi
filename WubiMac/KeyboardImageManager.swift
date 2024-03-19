//
//  KeyboardImageManager.swift
//  Wubi
//
//  Created by yongyou on 2022/10/11.
//  Copyright © 2022 sakuragi. All rights reserved.
//

#if os(macOS)
import AppKit
class KeyboardImageManager {
    static let shared = KeyboardImageManager()

    static let image98Keys = [
        "Q": [0, 83], "W": [124, 83], "E": [249, 83], "R": [374, 83], "T": [499, 83], "Y": [626, 83], "U": [750, 83], "I": [875, 83], "O": [1000, 83], "P": [1125, 83],
        "A": [35, 222], "S": [160, 222], "D": [285, 222], "F": [410, 222], "G": [535, 222], "H": [661, 222], "J": [786, 222], "K": [911, 222], "L": [1036, 222],
        "Z": [96, 360], "X": [221, 360], "C": [346, 360], "V": [471, 360], "B": [595, 360], "N": [720, 360], "M": [847, 360]
    ]

    static let image86Keys = [
        "Q": [0, 81], "W": [121, 81], "E": [242, 81], "R": [363, 81], "T": [484, 81], "Y": [607, 81], "U": [728, 81], "I": [849, 81], "O": [970, 81], "P": [1091, 81],
        "A": [34, 215], "S": [155, 215], "D": [276, 215], "F": [397, 215], "G": [518, 215], "H": [641, 215], "J": [762, 215], "K": [883, 215], "L": [1005, 215],
        "Z": [93, 348], "X": [214, 348], "C": [335, 348], "V": [457, 348], "B": [577, 348], "N": [699, 348], "M": [821, 348]
    ]

//142
    static let imagegbkKeys = [
        "Q": [169, 241], "W": [311, 241], "E": [448, 241], "R": [590, 241], "T": [726, 241], "Y": [881, 241], "U": [1020, 241], "I": [1160, 241], "O": [1302, 241], "P": [1440, 241],
        "A": [204, 446], "S": [344, 446], "D": [485, 446], "F": [626, 446], "G": [767, 446], "H": [921, 446], "J": [1062, 446], "K": [883, 446], "L": [1005, 446],
        "Z": [261, 656], "X": [402, 656], "C": [543, 656], "V": [684, 656], "B": [825, 656], "N": [965, 656], "M": [1120, 656]
    ]

//    private override init() {
//        super.init()
//    }

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
        for (key, value) in KeyboardImageManager.image98Keys {
            let rect = NSRect(x: value[0], y: value[1], width: 113, height: 121)
            dict[key] = image?.cropping(to: rect)
        }
        return dict
    }()

    public lazy var imagegbkDict : Dictionary<String, NSImage> = {
        var dict = Dictionary<String, NSImage>()
        let image = NSImage.init(named: "iWuBi-gbk-keyboard")
        for (key, value) in KeyboardImageManager.imagegbkKeys {
            let rect = NSRect(x: value[0], y: value[1], width: 120, height: 148)
            dict[key] = image?.cropping(to: rect)
        }
        return dict
    }()


    public lazy var image86Dict : Dictionary<String, NSImage> = {
        var dict = Dictionary<String, NSImage>()
        let image = NSImage.init(named: "iWuBi-86-keyboard")
        for (key, value) in KeyboardImageManager.image86Keys {
            let rect = NSRect(x: value[0], y: value[1], width: 109, height: 117)
            dict[key] = image?.cropping(to: rect)
        }
        return dict
    }()


    public lazy var rect98Dict : Dictionary<String, NSRect> = {
        var dict = Dictionary<String, NSRect>()
        let image = NSImage.init(named: "iWuBi-98-keyboard")
        for (key, value) in KeyboardImageManager.image98Keys {
            let rect = NSRect(x: value[0], y: value[1], width: 113, height: 121)
            dict[key] = rect
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




