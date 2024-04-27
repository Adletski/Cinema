// SkeletonPersonCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SkeletonPersonCollectionViewCell: UICollectionViewCell {
    static let identifier = "SkeletonPersonCollectionViewCell"

    // MARK: - UI Elements

    private let personView = SkeletonView()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func setupUI() {
        contentView.addSubview(personView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            personView.topAnchor.constraint(equalTo: contentView.topAnchor),
            personView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            personView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            personView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
