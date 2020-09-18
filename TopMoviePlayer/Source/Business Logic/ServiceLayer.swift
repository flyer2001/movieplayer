//
//  ServiceLayer.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 16.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Apexy

final class ServiceLayer {

    // MARK: - Public properties

    static let shared = ServiceLayer()

    private(set) lazy var apiClient: Client = {
        return Apexy.Client(
            baseURL: URL(string: "https://api.themoviedb.org/3/")!,
            configuration: .ephemeral)
    }()

    private(set) lazy var popularFilmService: PopularFilmService = PopularFilmServiceImpl(apiClient: apiClient)

    private(set) lazy var videoService: VideoService = VideoServiceImpl(apiClient: apiClient)

}
