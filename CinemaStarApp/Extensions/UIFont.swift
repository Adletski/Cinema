// UIFont.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIFont {
    static func inter(ofSize: CGFloat) -> UIFont {
        UIFont(name: "Inter-Medium", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }

    static func interBold(ofSize: CGFloat) -> UIFont {
        UIFont(name: "Inter-Bold", size: ofSize) ?? UIFont.systemFont(ofSize: ofSize)
    }

    static var fontStoreMap: [String: UIFont] = [:]
    static func font(name: String, size: CGFloat) -> UIFont? {
        let keyFont = "\(name)\(size)"
        if let font = fontStoreMap[keyFont] {
            return font
        }
        let newFont = UIFont(name: name, size: size)
        fontStoreMap[keyFont] = newFont
        return newFont
    }
}
