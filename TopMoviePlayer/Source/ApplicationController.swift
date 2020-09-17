//
//  ApplicationController.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 15.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import UIKit

final class ApplicationController {

    // MARK: - Public methods

    ///Выполняет первоначальную настройку приложения
    static func start() {
        showMainScreen()
    }


    private static func showMainScreen() {
        UIWindow.keyWindowTransit(to: MainTabBarController())
    }

}
