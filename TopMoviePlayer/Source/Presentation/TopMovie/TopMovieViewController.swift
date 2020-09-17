//
//  MainScreenViewController.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 15.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import UIKit

final class TopMovieViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var retryButton: UIButton! {
        didSet {
            retryButton.layer.cornerRadius = 10
        }
    }

    // MARK: - Private Properties

    private let topMoviePresenter = TopMoviePresenter(popularFilmService: ServiceLayer.shared.popularFilmService)
    private var films: [TopMovieDate] = []

    // MARK: - ViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        topMoviePresenter.attachView(self)
        topMoviePresenter.fetchFilms()
    }

    // MARK: - IBActions

    @IBAction private func retryButtonPressed(_ sender: Any) {
        activityIndicator.startAnimating()
        errorLabel.isHidden = true
        retryButton.isHidden = true
        topMoviePresenter.fetchFilms()
    }

}

extension TopMovieViewController: TopMovieView {
    func startLoading() {
        activityIndicator.startAnimating()
    }

    func finishLoading() {
        activityIndicator.stopAnimating()
    }

    func fetchingError(description: String) {
        self.errorLabel.isHidden = false
        self.errorLabel.text = description
        self.retryButton.isHidden = false
    }

    func fetchFilms(_ films: [TopMovieDate]) {
        print(films)
        self.films = films
    }


}
