//
//  MainTabBarController.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 17.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let topMovieViewController = TopMovieViewController()
        let favoriteMovieViewController = FavoriteMovieViewController()
        self.viewControllers = [topMovieViewController, favoriteMovieViewController]

    }

}
