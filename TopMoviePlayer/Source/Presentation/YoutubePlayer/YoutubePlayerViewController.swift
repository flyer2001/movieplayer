//
//  YoutubePlayerViewController.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 19.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class YoutubePlayerViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var descriptionErrorLabel: UILabel!
    @IBOutlet private var retryButton: UIButton!

    // MARK: - Private Properties

    private let filmId: Int
    private let presenter: YoutubePlayerPresenter
    private let playerView = YTPlayerView()

    // MARK: - Initializers

    init(filmId: Int) {
        self.filmId = filmId
        presenter = YoutubePlayerPresenter(videoService: ServiceLayer.shared.videoService, filmId: filmId)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.youtubePlayerView = self
        presenter.getYoutubeKey()
    }

    // MARK: - IBActions

    @IBAction private func retryButtonPressed(_ sender: Any) {
        activityIndicator.startAnimating()
        descriptionErrorLabel.isHidden = true
        retryButton.isHidden = true
        presenter.getYoutubeKey()
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }

    // MARK: - Private Methods

    private func showPlayer(youtubeId: String) {
        playerView.load(withVideoId: youtubeId)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)
        playerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        playerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        playerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
}

// MARK: - YoutubePlayerView

extension YoutubePlayerViewController: YoutubePlayerView {

    func startLoading() {
        activityIndicator.startAnimating()
    }

    func getYoutubeVideoID(_ id: String) {
        activityIndicator.stopAnimating()
        showPlayer(youtubeId: id)
    }

    func loadingError(_ description: String) {
        descriptionErrorLabel.isHidden = false
        descriptionErrorLabel.text = description
        retryButton.isHidden = false
    }


}
