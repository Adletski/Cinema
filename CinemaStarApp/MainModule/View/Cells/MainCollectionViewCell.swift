// MainCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    static let identifier = "MainViewCell"

    // MARK: - UI Elements

    private let filmImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        return imageView
    }()

    private let filmTitleLabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.text = "Земля\n" + "⭐️ " + "8,3"
        label.font = .inter(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Public Properties

    var filmId: Int?

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

    func configureCell(info: Film) {
        imageRequest = ImageRequest(url: info.imageURL)
        imageRequest?.execute(withCompletion: { [weak self] image in
            self?.filmImageView.image = image
        })
        filmId = info.id
        filmTitleLabel.text = info.name
        filmTitleLabel.text = "\(info.name)\n⭐️ \(info.rating)"
    }

    // MARK: - Private Methods

    private func setupUI() {
        contentView.addSubview(filmImageView)
        contentView.addSubview(filmTitleLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            filmImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            filmImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            filmImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            filmImageView.heightAnchor.constraint(equalToConstant: 200),

            filmTitleLabel.topAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: 4),
            filmTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            filmTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            filmTitleLabel.heightAnchor.constraint(equalToConstant: 60),
            filmTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
