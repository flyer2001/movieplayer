//
//  Film.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 16.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Foundation

struct Film: Decodable {

    /// ID фильма картотеки
    let id: Int

    /// Путь к постеру фильма
    let posterPath: String

    /// Название фильма
    let title: String

    /// Описание фильма
    let overview: String

}
