//
//  PopularFilmService.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 16.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Apexy

// Сервис для работы со списком популярных фильмов
protocol PopularFilmService: AnyObject {

    // Получить список популярных фильмов
    func fetchPopularFilms(page: Int, completion: @escaping (Result<[Film], Error>) -> Void)
}

final class PopularFilmServiceImpl: PopularFilmService {

    // MARK: - Private Properties

    private let apiClient: Client

    // MARK: - Initializers

    init(apiClient: Client) {
        self.apiClient = apiClient
    }

    // MARK: - Public Methods

    /// Получить с сервера список пользователей
    func fetchPopularFilms(page: Int, completion: @escaping (Result<[Film], Error>) -> Void) {
        let endpoint = PopularFilmsEndpoint(page: page)
        apiClient.request(endpoint) { result in
            switch result {
            case .failure(let error ):
                if let err = error.asAFError, err.isRequestRetryError {
                    self.fetchPopularFilms(page: page, completion: completion)
                } else {
                    completion(.failure(error))
                }
            case .success(let film):
                completion(.success(film))
            }
        }
    }

}


