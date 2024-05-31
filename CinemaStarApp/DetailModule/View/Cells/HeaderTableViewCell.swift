// HeaderTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class HeaderTableViewCell: UITableViewCell {
    static let identifier = "HeaderTableViewCell"

    // MARK: - UI Elements

    private let photoFilmImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        return imageView
    }()

    private let filmTitleLabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .inter(ofSize: 18)
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var watchButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(watchButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Смотреть", for: .normal)
        button.backgroundColor = .appDarkGreen
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .inter(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    var watchButtonClosure: VoidHandler?

    // MARK: - Private Properties

    private var imageRequest: ImageRequest?

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

    func configure(imageUrl: URL, filmName: String, filmRate: String) {
        filmTitleLabel.text = "\(filmName)\n⭐️ \(filmRate)"
        imageRequest = ImageRequest(url: imageUrl)
        imageRequest?.execute(withCompletion: { [weak self] image in
            self?.photoFilmImageView.image = image
        })
    }

    // MARK: - Private Methods

    @objc private func watchButtonDidTap() {
        watchButtonClosure?()
    }

    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(photoFilmImageView)
        contentView.addSubview(filmTitleLabel)
        contentView.addSubview(watchButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoFilmImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoFilmImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            photoFilmImageView.widthAnchor.constraint(equalToConstant: 170),
            photoFilmImageView.heightAnchor.constraint(equalToConstant: 200),

            filmTitleLabel.centerYAnchor.constraint(equalTo: photoFilmImageView.centerYAnchor),
            filmTitleLabel.leftAnchor.constraint(equalTo: photoFilmImageView.rightAnchor, constant: 16),
            filmTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            filmTitleLabel.heightAnchor.constraint(equalToConstant: 110),

            watchButton.topAnchor.constraint(equalTo: photoFilmImageView.bottomAnchor, constant: 16),
            watchButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            watchButton.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            watchButton.heightAnchor.constraint(equalToConstant: 48),
            watchButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
