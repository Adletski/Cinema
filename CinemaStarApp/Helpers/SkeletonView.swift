// SkeletonView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SkeletonView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        startSkeletonAnimate()
    }

    override func willRemoveSubview(_ subview: UIView) {
        super.willRemoveSubview(subview)
        stopSkeletonAnimate()
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        layer.cornerRadius = 8
    }
}
