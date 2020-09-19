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
    @IBOutlet private var tableView: UITableView!

    // MARK: - Private Properties

    private let topMoviePresenter = TopMoviePresenter(
        popularFilmService: ServiceLayer.shared.popularFilmService,
        storageService: ServiceLayer.shared.storageService)

    // MARK: - ViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        topMoviePresenter.topMoviewView = self
        topMoviePresenter.fetchFilms()
        tableView.registerCellNib(TopViewTableViewCell.self)
        tableView.prefetchDataSource = self
    }

    // MARK: - IBActions

    @IBAction private func retryButtonPressed(_ sender: Any) {
        activityIndicator.startAnimating()
        errorLabel.isHidden = true
        retryButton.isHidden = true
        topMoviePresenter.fetchFilms()
    }

    // MARK: - Private Methods

    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        indexPath.row >= topMoviePresenter.currentFilmsCount - 1
    }

}

// MARK: - TopViewTableViewCellDelegate

extension TopMovieViewController: TopViewTableViewCellDelegate {

    func addToFavorite(filmId: Int) {
        topMoviePresenter.addToFavorite(filmId)
        //tableView.reloadData()
    }

    func removeFromFavorite(filmId: Int) {
        topMoviePresenter.removeFromFavorite(filmId)
        //tableView.reloadData()
    }

}

// MARK: - TopMovieView

extension TopMovieViewController: TopMovieView {

    func fetchFilmsCompleted() {
        tableView.reloadData()
    }

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

}

// MARK: - UITableViewDataSourcePrefetching

extension TopMovieViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            topMoviePresenter.fetchFilms()
        }
    }

}

// MARK: - UITableViewDataSource

extension TopMovieViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.topMoviePresenter.currentFilmsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(TopViewTableViewCell.self, for: indexPath)
        cell.delegate = self
        cell.configure(with: topMoviePresenter.getFilmData(at: indexPath.row))
        return cell
    }


}
