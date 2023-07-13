//
//  NSImage+Exs.swift
//  WubiMac
//
//  Created by yongyou on 2023/7/13.
//

import Foundation
import AppKit


extension NSImage {
    func cropping(to rect: CGRect) -> NSImage {
        var imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let imageRef = self.cgImage(forProposedRect: &imageRect, context: nil, hints: nil) else {
            return NSImage(size: rect.size)
        }
        guard let crop = imageRef.cropping(to: rect) else {
            return NSImage(size: rect.size)
        }
        return NSImage(cgImage: crop, size: NSZeroSize)
    }
}
