// RecommendFilmTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class RecommendFilmTableViewCell: UICollectionViewCell {
    static let identifier = "RecommendFilmViewCell"

    // MARK: - UI Elements

    private let filmImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .inter(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Private Properties

    private var imageRequest: ImageRequest?

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

    // MARK: - Public Methods

    func configureCell(recommendFilm: SimilarMoviesDTO) {
        imageRequest = ImageRequest(url: recommendFilm.poster.url)
        imageRequest?.execute(withCompletion: { [weak self] image in
            self?.filmImageView.image = image
        })
        nameLabel.text = recommendFilm.name
    }

    // MARK: - Private Methods

    private func setupUI() {
        contentView.addSubview(filmImageView)
        contentView.addSubview(nameLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            filmImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            filmImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            filmImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -11),
            filmImageView.widthAnchor.constraint(equalToConstant: 170),
            filmImageView.heightAnchor.constraint(equalToConstant: 200),

            nameLabel.topAnchor.constraint(equalTo: filmImageView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: filmImageView.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: filmImageView.rightAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
