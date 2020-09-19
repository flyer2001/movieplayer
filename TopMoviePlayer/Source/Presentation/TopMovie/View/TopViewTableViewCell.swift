//
//  TopViewTableViewCell.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 18.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import UIKit
import Kingfisher

protocol TopViewTableViewCellDelegate: AnyObject {
    func addToFavorite(filmId: Int)
    func removeFromFavorite(filmId: Int)
}

class TopViewTableViewCell: NibTableViewCell {

    // MARK: - IBOutlet

    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var favoriteButton: FavoriteButton!

    // MARK: - Public Properties

    weak var delegate: TopViewTableViewCellDelegate?
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
        if let film = film {
            id = film.id
            titleText = film.title
            descritptionText = film.description
            posterImageURL = film.posterURL
            activityIndicator.stopAnimating()
            isFavorite = film.isFavorite
            isHidenAll(false)


        } else {
            activityIndicator.startAnimating()
            isHidenAll(true)
        }
    }

    // MARK: - IBActions

    @IBAction func favoriteButtonPressed(_ sender: Any) {
        isFavorite.toggle()
        switch isFavorite {
        case true:
            delegate?.addToFavorite(filmId: id)
        case false:
            delegate?.removeFromFavorite(filmId: id)
        }
    }


    // MARK: - Private Methods

    private func isHidenAll(_ isHidden: Bool) {
        posterImageView.isHidden = isHidden
        titleLabel.isHidden = isHidden
        descriptionLabel.isHidden = isHidden
    }
    
}
