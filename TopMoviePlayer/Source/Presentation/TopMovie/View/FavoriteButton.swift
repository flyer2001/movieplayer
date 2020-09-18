//
//  FavoriteButton.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 18.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import UIKit

// Кнопка добавления в избранное
final class FavoriteButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }

    // MARK: - Private Methods

    private func setupButton() {
        setImage(#imageLiteral(resourceName: "star_button"), for: .normal)
        setImage(#imageLiteral(resourceName: "star_button_filled"), for: .selected)
        isSelected = false
    }

}
