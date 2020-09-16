//
//  MainScreenViewController.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 15.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    private let popularFilmService = ServiceLayer.shared.popularFilmService
    var films: [Film] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFilms()
    }

    private func fetchFilms(){
        popularFilmService.fetchPopularFilms(page: 1) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let films):
                print(films)
                self.films = films
            }
        }
    }

}
