// MainViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MainViewController: UIViewController {
    // MARK: - UI Elements

    private let titleLabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        let attrString = NSMutableAttributedString(
            string: "Смотри исторические \nфильмы на ",
            attributes: [NSAttributedString.Key.font: UIFont.inter(ofSize: 20)]
        )
        let logoAttrString = NSAttributedString(
            string: "CINEMA STAR",
            attributes: [NSAttributedString.Key.font: UIFont.interBold(ofSize: 20)]
        )
        attrString.append(logoAttrString)
        label.attributedText = attrString
        return label
    }()

    private lazy var catalogCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0.5
        layout.itemSize = .init(width: Int((UIScreen.main.bounds.width / 2) - 25), height: 248)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(
            SkeletonCollectionViewCell.self,
            forCellWithReuseIdentifier: SkeletonCollectionViewCell.identifier
        )
        collectionView.register(
            MainCollectionViewCell.self,
            forCellWithReuseIdentifier: MainCollectionViewCell.identifier
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - Public Properties

    var mainViewModel: MainViewModelProtocol?

    // MARK: - Private Properties

    private var viewState: ViewState<[Film]> = .loading {
        didSet {
            catalogCollectionView.reloadData()
            if case .data = viewState {
                catalogCollectionView.isUserInteractionEnabled = true
            }
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        setupUI()
        setupConstraints()
        configureNavigationBar()
        mainViewModel?.startFetch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - Private Methods

    private func setupUI() {
        view.setupAppGradientBackground()
        view.addSubview(titleLabel)
        view.addSubview(catalogCollectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            catalogCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            catalogCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            catalogCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            catalogCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -74),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.backIndicatorImage = .chevronLeft
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = .chevronLeft
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.backBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func updateView() {
        mainViewModel?.updateViewState = { [weak self] viewData in
            self?.viewState = viewData
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MainCollectionViewCell else { return }
        mainViewModel?.showDetailFilm(id: cell.filmId)
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewState {
        case .loading:
            return 20
        case let .data(films):
            return films.count
        default:
            return 0
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch viewState {
        case .loading:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SkeletonCollectionViewCell.identifier,
                for: indexPath
            ) as? SkeletonCollectionViewCell else { return UICollectionViewCell() }
            return cell
        case let .data(films):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MainCollectionViewCell.identifier,
                for: indexPath
            ) as? MainCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(info: films[indexPath.row])
            return cell
        default:
            break
        }
        return UICollectionViewCell()
    }
}
