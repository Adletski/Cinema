// DescriptionTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class DescriptionTableViewCell: UITableViewCell {
    static let identifier = "DescriptionViewCell"

    // MARK: - UI Elements

    private let descriptionLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 5
        label.font = .inter(ofSize: 14)
        return label
    }()

    private let filmInfoLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .appDarkGray
        label.font = .inter(ofSize: 14)
        return label
    }()

    private let languageInfoLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .appDarkGray
        label.font = .inter(ofSize: 14)
        return label
    }()

    private lazy var openDescriptionButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(openDescriptionButtonDidTap), for: .touchUpInside)
        button.setImage(.chevronDown, for: .normal)
        button.setImage(.chevronUp, for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()

    private lazy var personsCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.1
        layout.minimumInteritemSpacing = 10
        layout.itemSize = .init(width: 60, height: 97)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(
            PersonCollectionViewCell.self,
            forCellWithReuseIdentifier: PersonCollectionViewCell.identifier
        )
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        return collectionView
    }()

    private lazy var personsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Актеры и съемочная группа"
        label.textColor = .white
        label.font = .interBold(ofSize: 14)
        return label
    }()

    private lazy var languageTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Язык"
        label.textColor = .white
        label.font = .interBold(ofSize: 14)
        return label
    }()

    private lazy var watchTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Смотрите также"
        label.textColor = .white
        label.font = .interBold(ofSize: 14)
        return label
    }()

    // MARK: - Public Properties

    var updateTable: VoidHandler?

    // MARK: - Private Properties

    private var persons: [PersonDTO] = []

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

    func configure(film: Detail) {
        persons = film.persons
        descriptionLabel.text = film.description
        var infoText = ""
        if let year = film.year {
            infoText += "\(year) /"
        }

        if let country = film.country {
            infoText += " \(country) /"
        }
        infoText += " \(film.type.rawValue)"

        filmInfoLabel.text = infoText
        languageInfoLabel.text = film.spokenLanguage
        if descriptionLabel.isTruncated { openDescriptionButton.isHidden = false }
    }

    // MARK: - Private Methods

    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(filmInfoLabel)
        contentView.addSubview(openDescriptionButton)
        contentView.addSubview(personsTitleLabel)
        contentView.addSubview(personsCollectionView)
        contentView.addSubview(languageTitleLabel)
        contentView.addSubview(languageInfoLabel)
        contentView.addSubview(watchTitleLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -44),
            descriptionLabel.bottomAnchor.constraint(equalTo: filmInfoLabel.topAnchor, constant: -10),

            filmInfoLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            filmInfoLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            filmInfoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            filmInfoLabel.heightAnchor.constraint(equalToConstant: 20),

            openDescriptionButton.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            openDescriptionButton.leftAnchor.constraint(equalTo: descriptionLabel.rightAnchor),
            openDescriptionButton.widthAnchor.constraint(equalToConstant: 24),
            openDescriptionButton.heightAnchor.constraint(equalToConstant: 24),

            personsTitleLabel.topAnchor.constraint(equalTo: filmInfoLabel.bottomAnchor, constant: 16),
            personsTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            personsTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            personsTitleLabel.heightAnchor.constraint(equalToConstant: 20),

            personsCollectionView.topAnchor.constraint(equalTo: personsTitleLabel.bottomAnchor, constant: 10),
            personsCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            personsCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            personsCollectionView.heightAnchor.constraint(equalToConstant: 97),

            languageTitleLabel.topAnchor.constraint(equalTo: personsCollectionView.bottomAnchor, constant: 14),
            languageTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            languageTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            languageTitleLabel.heightAnchor.constraint(equalToConstant: 20),

            languageInfoLabel.topAnchor.constraint(equalTo: languageTitleLabel.bottomAnchor, constant: 4),
            languageInfoLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            languageInfoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            languageInfoLabel.heightAnchor.constraint(equalToConstant: 20),

            watchTitleLabel.topAnchor.constraint(equalTo: languageInfoLabel.bottomAnchor, constant: 10),
            watchTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            watchTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            watchTitleLabel.heightAnchor.constraint(equalToConstant: 20),
            watchTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @objc private func openDescriptionButtonDidTap(button: UIButton) {
        if button.isSelected {
            UIView.animate(withDuration: 1.0) {
                self.descriptionLabel.numberOfLines = 5
            }
        } else {
            UIView.animate(withDuration: 1.0) {
                self.descriptionLabel.numberOfLines = 0
            }
        }
        button.isSelected.toggle()
        updateTable?()
    }
}

// MARK: - UICollectionViewDataSource

extension DescriptionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        persons.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PersonCollectionViewCell.identifier,
            for: indexPath
        ) as? PersonCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(personName: persons[indexPath.item].name, personImageUrl: persons[indexPath.item].photo)
        return cell
    }
}
