//
//  NSImage+Exs.swift
//  Wubi
//
//  Created by yongyou on 2023/7/13.
//

import Foundation

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

#if os(macOS)
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
#elseif os(iOS)


extension UIImage {
    func cropping(to rect: CGRect) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        let contextImage: UIImage = UIImage(cgImage: cgImage)
        guard let newCgImage = contextImage.cgImage?.cropping(to: rect) else { return nil }
        let image: UIImage = UIImage(cgImage: newCgImage, scale: self.scale, orientation: self.imageOrientation)
        return image
    }
}

#endif
