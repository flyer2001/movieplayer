//
//  YoutubePlayerView.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 19.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Foundation

protocol YoutubePlayerView: NSObjectProtocol {
    func startLoading()
    func getYoutubeVideoID(_ id: String)
    func loadingError(_ description: String)
}
