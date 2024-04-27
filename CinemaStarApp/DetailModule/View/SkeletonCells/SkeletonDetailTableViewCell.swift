// SkeletonDetailTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SkeletonDetailTableViewCell: UITableViewCell {
    static let identifier = "SkeletonDetailTableViewCell"

    // MARK: - UI Elements

    private let photoFilmView = SkeletonView()
    private let filmTitleView = SkeletonView()
    private let watchButtonView = SkeletonView()
    private let descriptionView = SkeletonView()
    private let filmInfoView = SkeletonView()
    private let personsTitleView = SkeletonView()
    private let languageTitleView = SkeletonView()
    private let languageInfoView = SkeletonView()
    private let recommendTitleView = SkeletonView()
    private let recommendInfoView = SkeletonView()

    private lazy var personsCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.itemSize = .init(width: 60, height: 97)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(
            SkeletonPersonCollectionViewCell.self,
            forCellWithReuseIdentifier: SkeletonPersonCollectionViewCell.identifier
        )
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        backgroundColor = .clear
        contentView.addSubview(photoFilmView)
        contentView.addSubview(filmTitleView)
        contentView.addSubview(watchButtonView)
        contentView.addSubview(descriptionView)
        contentView.addSubview(filmInfoView)
        contentView.addSubview(personsTitleView)
        contentView.addSubview(personsCollectionView)
        contentView.addSubview(languageTitleView)
        contentView.addSubview(languageInfoView)
        contentView.addSubview(recommendTitleView)
        contentView.addSubview(recommendInfoView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoFilmView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoFilmView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            photoFilmView.widthAnchor.constraint(equalToConstant: 170),
            photoFilmView.heightAnchor.constraint(equalToConstant: 200),

            filmTitleView.centerYAnchor.constraint(equalTo: photoFilmView.centerYAnchor),
            filmTitleView.leftAnchor.constraint(equalTo: photoFilmView.rightAnchor, constant: 16),
            filmTitleView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            filmTitleView.heightAnchor.constraint(equalToConstant: 110),

            watchButtonView.topAnchor.constraint(equalTo: photoFilmView.bottomAnchor, constant: 16),
            watchButtonView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            watchButtonView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            watchButtonView.heightAnchor.constraint(equalToConstant: 48),

            descriptionView.topAnchor.constraint(equalTo: watchButtonView.bottomAnchor, constant: 16),
            descriptionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            descriptionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -44),
            descriptionView.heightAnchor.constraint(equalToConstant: 100),

            filmInfoView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 10),
            filmInfoView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            filmInfoView.widthAnchor.constraint(equalToConstant: 202),
            filmInfoView.heightAnchor.constraint(equalToConstant: 20),

            personsTitleView.topAnchor.constraint(equalTo: filmInfoView.bottomAnchor, constant: 16),
            personsTitleView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            personsTitleView.widthAnchor.constraint(equalToConstant: 202),
            personsTitleView.heightAnchor.constraint(equalToConstant: 20),

            personsCollectionView.topAnchor.constraint(equalTo: personsTitleView.bottomAnchor, constant: 10),
            personsCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            personsCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            personsCollectionView.heightAnchor.constraint(equalToConstant: 97),

            languageTitleView.topAnchor.constraint(equalTo: personsCollectionView.bottomAnchor, constant: 14),
            languageTitleView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            languageTitleView.widthAnchor.constraint(equalToConstant: 202),
            languageTitleView.heightAnchor.constraint(equalToConstant: 20),

            languageInfoView.topAnchor.constraint(equalTo: languageTitleView.bottomAnchor, constant: 4),
            languageInfoView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            languageInfoView.widthAnchor.constraint(equalToConstant: 202),
            languageInfoView.heightAnchor.constraint(equalToConstant: 20),

            recommendTitleView.topAnchor.constraint(equalTo: languageInfoView.bottomAnchor, constant: 8),
            recommendTitleView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            recommendTitleView.widthAnchor.constraint(equalToConstant: 170),
            recommendTitleView.heightAnchor.constraint(equalToConstant: 200),

            recommendInfoView.topAnchor.constraint(equalTo: recommendTitleView.bottomAnchor, constant: 8),
            recommendInfoView.leftAnchor.constraint(equalTo: recommendTitleView.leftAnchor),
            recommendInfoView.widthAnchor.constraint(equalToConstant: 202),
            recommendInfoView.heightAnchor.constraint(equalToConstant: 20),
            recommendInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension SkeletonDetailTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: SkeletonPersonCollectionViewCell.self),
            for: indexPath
        ) as? SkeletonPersonCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}
