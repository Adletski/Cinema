// PersonCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class PersonCollectionViewCell: UICollectionViewCell {
    static let identifier = "PersonViewCell"

    // MARK: - UI Elements

    private let personImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .inter(ofSize: 8)
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

    func configure(personName: String?, personImageUrl: URL?) {
        nameLabel.text = personName
        if let url = personImageUrl {
            imageRequest = ImageRequest(url: url)
            imageRequest?.execute(withCompletion: { [weak self] image in
                self?.personImageView.image = image
            })
        }
    }

    // MARK: - Private Methods

    private func setupUI() {
        contentView.addSubview(personImageView)
        contentView.addSubview(nameLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            personImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            personImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 11),
            personImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -11),
            personImageView.widthAnchor.constraint(equalToConstant: 46),

            nameLabel.topAnchor.constraint(equalTo: personImageView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: personImageView.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: personImageView.rightAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
