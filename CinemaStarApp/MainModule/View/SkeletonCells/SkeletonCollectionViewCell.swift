// SkeletonCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SkeletonCollectionViewCell: UICollectionViewCell {
    static let identifier = "SkeletonCollectionViewCell"

    // MARK: - UI Elements

    private let photoFilmView = SkeletonView()
    private let filmTitleView = SkeletonView()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }

    // MARK: - Private Methods

    private func setupUI() {
        contentView.addSubview(photoFilmView)
        contentView.addSubview(filmTitleView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoFilmView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoFilmView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            photoFilmView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            photoFilmView.heightAnchor.constraint(equalToConstant: 200),

            filmTitleView.topAnchor.constraint(equalTo: photoFilmView.bottomAnchor, constant: 8),
            filmTitleView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            filmTitleView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            filmTitleView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
