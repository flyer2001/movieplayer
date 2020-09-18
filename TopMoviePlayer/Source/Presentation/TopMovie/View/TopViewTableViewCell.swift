//
//  TopViewTableViewCell.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 18.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import UIKit
import Kingfisher

class TopViewTableViewCell: NibTableViewCell {

    // MARK: - IBOutlet

    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var favoriteButton: FavoriteButton!

    // MARK: - Public Properties

    var id: Int = 0
    var isFavorite: Bool = false {
        didSet {
            favoriteButton.isSelected = isFavorite
        }
    }
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    var descritptionText: String? {
        didSet {
            descriptionLabel.text = descritptionText
        }
    }

    var posterImageURL: URL? {
        didSet {
            posterImageView.kf.indicatorType = .activity
            posterImageView.kf.setImage(with: posterImageURL)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none)
    }

    // MARK: - Public Methods

    func configure(with film: TopMovieData?) {
        // TODO: - продумать логику как сверять с CoreData
        isFavorite = false
        if let film = film {
            id = film.id
            titleText = film.title
            descritptionText = film.description
            posterImageURL = film.posterURL
            activityIndicator.stopAnimating()
            isHidenAll(false)


        } else {
            activityIndicator.startAnimating()
            isHidenAll(true)
        }
    }

    // MARK: - IBActions

    @IBAction func favoriteButtonPressed(_ sender: Any) {
        // TODO: Добавить делегат и передать в CoreData с
        isFavorite.toggle()
    }


    // MARK: - Private Methods

    private func isHidenAll(_ isHidden: Bool) {
        posterImageView.isHidden = isHidden
        titleLabel.isHidden = isHidden
        descriptionLabel.isHidden = isHidden
    }
    
}
