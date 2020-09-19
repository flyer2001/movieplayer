//
//  YoutubePlayerPresenter.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 19.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Foundation

final class YoutubePlayerPresenter {

    // MARK: - Public Properties

    weak var youtubePlayerView: YoutubePlayerView?

    // MARK: - Private Properties

    private let videoService: VideoService
    private let filmId: Int

    // MARK: - Initializers

    init(videoService: VideoService, filmId: Int) {
        self.videoService = videoService
        self.filmId = filmId
    }

    // MARK: - Public Methods

    func getYoutubeKey() {
        youtubePlayerView?.startLoading()
        videoService.fetchYoutubeKey(filmId: filmId) { result in
            switch result {
            case .failure(let error):
                self.youtubePlayerView?.loadingError(error.localizedDescription)
            case .success(let youtubeVideo):
                self.youtubePlayerView?.getYoutubeVideoID(youtubeVideo.key)
            }
        }
    }
}
