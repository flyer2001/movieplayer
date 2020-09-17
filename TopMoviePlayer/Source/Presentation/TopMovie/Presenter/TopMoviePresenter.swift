//
//  TopMoviePresenter.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 17.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Foundation

final class TopMoviePresenter {

    // MARK: - Private Properties

    private let popularFilmService: PopularFilmService
    private weak var topMoviewView: TopMovieView?

    // MARK: - Initializers

    init(popularFilmService: PopularFilmService) {
        self.popularFilmService = popularFilmService
    }

    // MARK: - Public Methods

    func attachView(_ view: TopMovieView) {
        topMoviewView = view
    }

    func fetchFilms(page: Int = 1) {
        topMoviewView?.startLoading()
        popularFilmService.fetchPopularFilms(page: page) { [weak self] result in
            guard let self = self else { return }
            self.topMoviewView?.finishLoading()
            switch result {
            case .failure(let error):
                self.topMoviewView?.fetchingError(description: error.localizedDescription)
            case .success(let films):
                let mappedViewData = films.map {
                    TopMovieDate(
                        id: $0.id,
                        title: $0.title,
                        description: $0.overview,
                        posterURL: URL(string: Constants.imageBasePath + $0.posterPath))
                }
                self.topMoviewView?.fetchFilms(mappedViewData)
            }
        }
    }


}
