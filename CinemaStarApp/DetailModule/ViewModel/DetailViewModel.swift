// DetailViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol DetailViewModelProtocol {
    init(coordinator: MainCoordinator, filmId: Int?)
    var updateViewState: ((ViewState<Detail>) -> ())? { get set }
    var isFavoriteFilm: Bool { get }
    func startFetch()
    func savePressedFavouriteFilm()
}

final class DetailViewModel: DetailViewModelProtocol {
    // MARK: - Public Properties

    public var updateViewState: ((ViewState<Detail>) -> ())?
    private var filmDetailRequest: APIRequest<DetailResource>?
    var isFavoriteFilm: Bool {
        guard let filmId else { return false }
        return UserDefaults.standard.value(forKey: "\(filmId)") != nil
    }

    // MARK: - Private Properties

    private let coordinator: MainCoordinator!
    private let filmId: Int?

    // MARK: - Initializers

    init(coordinator: MainCoordinator, filmId: Int?) {
        updateViewState?(.loading)
        self.coordinator = coordinator
        self.filmId = filmId
    }

    // MARK: - Public Methods

    func startFetch() {
        guard let filmId else { return }
        let filmDetailResource = DetailResource(path: "/\(filmId)")
        filmDetailRequest = APIRequest(resource: filmDetailResource)
        filmDetailRequest?.execute(withCompletion: { [weak self] filmDetailDTO in
            guard let filmDetailDTO else { return }
            let filmDetail = Detail(filmDetailDTO: filmDetailDTO)
            self?.updateViewState?(.data(filmDetail))
        })
    }

    func savePressedFavouriteFilm() {
        guard let filmId else { return }
        if isFavoriteFilm {
            UserDefaults.standard.removeObject(forKey: "\(filmId)")
        } else {
            UserDefaults.standard.set(true, forKey: "\(filmId)")
        }
    }
}
