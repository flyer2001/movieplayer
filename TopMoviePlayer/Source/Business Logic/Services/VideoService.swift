//
//  VideoService.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 18.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Apexy

struct VideoError: Error {
    let localizedDescription: String
}

// Сервис для работы со списком популярных фильмов
protocol VideoService: AnyObject {

    // Получить id трейлера на Youtbe
    func fetchPopularFilms(filmId: Int, completion: @escaping (Result<Video, Error>) -> Void)
}

final class VideoServiceImpl: VideoService {

    // MARK: - Private Properties

    private let apiClient: Client

    // MARK: - Initializers

    init(apiClient: Client) {
        self.apiClient = apiClient
    }

    // MARK: - Public Methods

    func fetchPopularFilms(filmId: Int, completion: @escaping (Result<Video, Error>) -> Void) {
        let endpoint = VideoEndpoint(id: filmId)
        apiClient.request(endpoint) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let videos):
                if let video = videos.first(where: { $0.site == "YouTube"}) {
                    completion(.success(video))
                } else {
                    completion(.failure(VideoError(localizedDescription: "Нет трейлера на YouTube")))
                }
            }
        }
    }

}


