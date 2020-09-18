//
//  TopMoviePresenter.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 17.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Foundation

final class TopMoviePresenter {

    // MARK: - Public Properties

    weak var topMoviewView: TopMovieView?
    var currentFilmsCount: Int {
        filmsData.count
    }

    // MARK: - Private Properties

    private var currentPage = 1
    private var filmsData: [TopMovieData] = []
    private let popularFilmService: PopularFilmService

    // MARK: - Initializers

    init(popularFilmService: PopularFilmService) {
        self.popularFilmService = popularFilmService
    }

    // MARK: - Public Methods

    func getFilmData(at index: Int) -> TopMovieData? {
        guard filmsData.indices.contains(index) else { return nil }
        return filmsData[index]
    }

    func fetchFilms() {
        topMoviewView?.startLoading()
        popularFilmService.fetchPopularFilms(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.topMoviewView?.finishLoading()
            switch result {
            case .failure(let error):
                self.topMoviewView?.fetchingError(description: error.localizedDescription)
            case .success(let films):
                // TODO: - Получить максимум страниц и отработать конец ленты
                let mappedViewData = films.map {
                    TopMovieData(
                        id: $0.id,
                        title: $0.title,
                        description: $0.overview,
                        posterURL: URL(string: Constants.imageBasePath + $0.posterPath))
                }
                self.filmsData.append(contentsOf: mappedViewData)
                self.topMoviewView?.fetchFilmsCompleted()
                self.currentPage += 1
            }
        }
    }
}
