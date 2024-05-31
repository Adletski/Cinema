// DetailViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// CellType
enum CellType {
    case header
    case info
    case recommendation
}

final class DetailViewController: UIViewController {
    // MARK: - UI Elements

    private lazy var detailInfoTableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isUserInteractionEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(
            SkeletonDetailTableViewCell.self,
            forCellReuseIdentifier: SkeletonDetailTableViewCell.identifier
        )
        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.identifier)
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.identifier)
        tableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: RecommendTableViewCell.identifier)
        return tableView
    }()

    // MARK: - Public Properties

    var filmDetailViewModel: DetailViewModelProtocol?

    // MARK: - Private Properties

    private let cellTypes: [CellType] = [.header, .info, .recommendation]
    private var viewState: ViewState<Detail> = .loading {
        didSet {
            configureNavigationBar()
            if case .data = viewState {
                detailInfoTableView.isUserInteractionEnabled = true
            }
            detailInfoTableView.reloadData()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        view.setupAppGradientBackground()
        filmDetailViewModel?.startFetch()
        updateView()
        configureNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Private Methods

    private func configureNavigationBar() {
        let likeBarButtonItem = UIBarButtonItem(
            image: .unlike,
            style: .plain,
            target: self,
            action: #selector(likeFilm)
        )
        likeBarButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = likeBarButtonItem

        if let filmDetailViewModel, filmDetailViewModel.isFavoriteFilm {
            likeBarButtonItem.image = .like
        }
    }

    private func setupUI() {
        view.addSubview(detailInfoTableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            detailInfoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailInfoTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            detailInfoTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            detailInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func updateView() {
        filmDetailViewModel?.updateViewState = { [weak self] state in
            self?.viewState = state
        }
    }

    private func showAlert() {
        let alert = UIAlertController(
            title: "Упс!",
            message: "Функционал в разработке :(",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }

    @objc private func likeFilm(barButton: UIBarButtonItem) {
        filmDetailViewModel?.savePressedFavouriteFilm()
        if barButton.image == .like {
            barButton.image = .unlike
        } else {
            barButton.image = .like
        }
    }
}

// MARK: - UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewState {
        case .loading:
            return 1
        case .data:
            return cellTypes.count
        case let .error(error):
            print(error)
            return 0
        case .noData:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewState {
        case .loading:
            guard let cell = detailInfoTableView
                .dequeueReusableCell(
                    withIdentifier: SkeletonDetailTableViewCell
                        .identifier
                ) as? SkeletonDetailTableViewCell
            else { return UITableViewCell() }
            return cell
        case let .data(detailFilm):
            let cellType = cellTypes[indexPath.row]
            switch cellType {
            case .header:
                guard let cell = detailInfoTableView
                    .dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as? HeaderTableViewCell
                else { return UITableViewCell() }
                cell.configure(imageUrl: detailFilm.poster, filmName: detailFilm.name, filmRate: detailFilm.rating)
                cell.watchButtonClosure = { [weak self] in
                    self?.showAlert()
                }
                return cell
            case .info:
                guard let cell = detailInfoTableView
                    .dequeueReusableCell(
                        withIdentifier: DescriptionTableViewCell
                            .identifier
                    ) as? DescriptionTableViewCell else { return UITableViewCell() }
                cell.configure(film: detailFilm)
                cell.updateTable = { [weak self] in
                    self?.detailInfoTableView.reloadData()
                }
                return cell
            case .recommendation:
                guard let cell = detailInfoTableView
                    .dequeueReusableCell(withIdentifier: RecommendTableViewCell.identifier) as? RecommendTableViewCell
                else { return UITableViewCell() }
                if let recommends = detailFilm.similarMovies {
                    cell.configureCell(recommends: recommends)
                }
                return cell
            }
        case let .error(error):
            print(error)
            return UITableViewCell()
        case .noData:
            return UITableViewCell()
        }
    }
}
