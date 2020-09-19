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

    private let presenter = TopMoviePresenter(
        popularFilmService: ServiceLayer.shared.popularFilmService,
        storageService: ServiceLayer.shared.storageService)

    // MARK: - ViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.topMoviewView = self
        presenter.fetchFilms()
        tableView.registerCellNib(TopMovieTableViewCell.self)
        tableView.prefetchDataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - IBActions

    @IBAction private func retryButtonPressed(_ sender: Any) {
        activityIndicator.startAnimating()
        errorLabel.isHidden = true
        retryButton.isHidden = true
        presenter.fetchFilms()
    }

    // MARK: - Private Methods

    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        indexPath.row >= presenter.currentFilmsCount - 1
    }

}

// MARK: - TopViewTableViewCellDelegate

extension TopMovieViewController: TopMovieTableViewCellDelegate {

    func addToFavorite(filmId: Int) {
        presenter.addToFavorite(filmId)
    }

    func removeFromFavorite(filmId: Int) {
        presenter.removeFromFavorite(filmId)
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
        errorLabel.isHidden = false
        errorLabel.text = description
        retryButton.isHidden = false
    }

}

// MARK: - UITableViewDataSourcePrefetching

extension TopMovieViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            presenter.fetchFilms()
        }
    }

}

// MARK: - UITableViewDataSource

extension TopMovieViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.currentFilmsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(TopMovieTableViewCell.self, for: indexPath)
        cell.delegate = self
        cell.configure(with: presenter.getFilmData(at: indexPath.row))
        return cell
    }


}

// MARK: - UITableViewDelegate

extension TopMovieViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedFilm = presenter.getFilmData(at: indexPath.row) else { return }
        let youtubePlayerViewController = YoutubePlayerViewController(filmId: selectedFilm.id)
        present(youtubePlayerViewController, animated: true)
    }
}

