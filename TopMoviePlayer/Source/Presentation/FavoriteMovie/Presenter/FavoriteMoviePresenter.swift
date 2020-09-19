//
//  FavoriteMoviePresenter.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 19.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Foundation

final class FavoriteMoviePresenter {

    // MARK: - Public Properties

    weak var favoriteMovieView: FavoriteMovieView?
    var currentFilmsCount: Int {
        filmsData.count
    }

    // MARK: - Private Properties

    private var filmsData: [TopMovieData] = []
    private let storageService: StorageService

    // MARK: - Initializers

    init(storageService: StorageService) {
        self.storageService = storageService
    }

    // MARK: - Public Methods

    func getFilmData(at index: Int) -> TopMovieData? {
        guard filmsData.indices.contains(index) else { return nil }
        return filmsData[index]
    }

    func removeFromFavorite(_ filmId: Int) {
        guard let index = filmsData.firstIndex(where: { $0.id == filmId}) else { return }
        storageService.deleteFromFavorite(filmsData[index])
        filmsData.remove(at: index)
    }

    func fetchFilms() {
        let filmsFromStorage = storageService.fetchAllFavoriteFilms()
        filmsData = filmsFromStorage
        favoriteMovieView?.fetchFavoriteFilmsCompleted()
    }
}
