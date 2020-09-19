//
//  FavoriteMovieViewController.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 17.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import UIKit

class FavoriteMovieViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet private var tableView: UITableView!

    // MARK: - Private Properties

    private let presenter = FavoriteMoviePresenter(storageService: ServiceLayer.shared.storageService)

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.favoriteMovieView = self
        tableView.registerCellNib(TopMovieTableViewCell.self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchFilms()
    }
}

// MARK: - FavoriteMovieView

extension FavoriteMovieViewController: FavoriteMovieView {

    func fetchFavoriteFilmsCompleted() {
        tableView.reloadData()
    }
}

// MARK: - TopMovieTableViewCellDelegate

extension FavoriteMovieViewController: TopMovieTableViewCellDelegate {

    func addToFavorite(filmId: Int) {}

    func removeFromFavorite(filmId: Int) {
        presenter.removeFromFavorite(filmId)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension FavoriteMovieViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.currentFilmsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(TopMovieTableViewCell.self, for: indexPath)
        cell.delegate = self
        cell.configure(with: presenter.getFilmData(at: indexPath.row))
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FavoriteMovieViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedFilm = presenter.getFilmData(at: indexPath.row) else { return }
        let youtubePlayerViewController = YoutubePlayerViewController(filmId: selectedFilm.id)
        present(youtubePlayerViewController, animated: true)
    }
}
