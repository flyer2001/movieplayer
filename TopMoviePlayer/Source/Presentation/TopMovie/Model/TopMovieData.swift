//
//  TopMovieDate.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 17.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Foundation

struct TopMovieData {
    let id: Int
    let title: String
    let description: String
    let posterURL: URL?
    var isFavorite: Bool
}

extension TopMovieData {

    init(topMovieDataModel: TopMovieDataModel) {
        id = Int(topMovieDataModel.id)
        title = topMovieDataModel.title
        description = topMovieDataModel.description_
        posterURL = topMovieDataModel.posterURL
        isFavorite = true
    }
}
