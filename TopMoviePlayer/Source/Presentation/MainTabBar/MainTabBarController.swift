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
        topMovieViewController.tabBarItem.title = "Топ фильмы"
        topMovieViewController.tabBarItem.image = UIImage(named: "film")
        let favoriteMovieViewController = FavoriteMovieViewController()
        favoriteMovieViewController.tabBarItem.title = "Избранные"
        favoriteMovieViewController.tabBarItem.image = UIImage(named: "star")
        self.viewControllers = [topMovieViewController, favoriteMovieViewController]

    }

}
