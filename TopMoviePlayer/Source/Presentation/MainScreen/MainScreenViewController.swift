//
//  MainScreenViewController.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 15.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet var retryButton: UIButton! {
        didSet {
            retryButton.layer.cornerRadius = 10
        }
    }

    // MARK: - Private Properties

    private let popularFilmService = ServiceLayer.shared.popularFilmService
    var films: [Film] = []

    // MARK: - ViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFilms()
    }

    // MARK: - IBActions

    @IBAction private func retryButtonPressed(_ sender: Any) {
        activityIndicator.startAnimating()
        errorLabel.isHidden = true
        retryButton.isHidden = true
        fetchFilms()
    }

    // MARK: - Private Methods

    private func fetchFilms(){
        popularFilmService.fetchPopularFilms(page: 1) { result in
            self.activityIndicator.stopAnimating()
            switch result {
            case .failure(let error):
                self.errorLabel.isHidden = false
                self.errorLabel.text = error.localizedDescription
                self.retryButton.isHidden = false
            case .success(let films):
                self.errorLabel.isHidden = true
                self.retryButton.isHidden = true
                self.films = films
            }
        }
    }

}
