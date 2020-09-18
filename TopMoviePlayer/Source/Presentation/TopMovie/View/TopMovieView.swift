//
//  TopMovieView.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 17.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import Foundation

protocol TopMovieView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func fetchingError(description: String)
    func fetchFilmsCompleted()
}
