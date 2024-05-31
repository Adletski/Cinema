// RecommendTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class RecommendTableViewCell: UITableViewCell {
    static let identifier = "RecommendTableViewCell"

    // MARK: - UI Elements

    private lazy var recommendCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.1
        layout.minimumInteritemSpacing = 10
        layout.itemSize = .init(width: 170, height: 240)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(
            RecommendFilmTableViewCell.self,
            forCellWithReuseIdentifier: RecommendFilmTableViewCell.identifier
        )
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - Private Properties

    private var recommends: [SimilarMoviesDTO] = []

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

    // MARK: - Public Methods

    func configureCell(recommends: [SimilarMoviesDTO]) {
        self.recommends = recommends
    }

    // MARK: - Private Methods

    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(recommendCollectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            recommendCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            recommendCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            recommendCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            recommendCollectionView.heightAnchor.constraint(equalToConstant: 240),
            recommendCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension RecommendTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recommends.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecommendFilmTableViewCell.identifier,
            for: indexPath
        ) as? RecommendFilmTableViewCell else { return UICollectionViewCell() }
        cell.configureCell(recommendFilm: recommends[indexPath.item])
        return cell
    }
}
