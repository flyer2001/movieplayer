//
//  Video.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 18.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Foundation

struct Video: Decodable {

    /// ID видео, если оно на youtube
    let key: String

    /// Сайт, с которого видео
    let site: String
}
