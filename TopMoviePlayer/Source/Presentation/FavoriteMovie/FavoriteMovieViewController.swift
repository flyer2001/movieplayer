//
//  FavoriteMovieViewController.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 17.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class FavoriteMovieViewController: UIViewController {

    let playerView = YTPlayerView()
    let service = ServiceLayer.shared.videoService

    override func viewDidLoad() {
        super.viewDidLoad()

        playerView.load(withVideoId: "sog_5eZFSdE")
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)
        playerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        playerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        playerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func getVideo() {
        service.fetchPopularFilms(filmId: 80079) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let video):
                self.playerView.load(withVideoId: video.key)
            }
        }
    }


}
