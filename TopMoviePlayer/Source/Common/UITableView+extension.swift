//
//  UITableView+extension.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 18.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import UIKit

typealias NibTableViewCell = UITableViewCell & NibRepresentable

extension UITableView {

    func registerCellNib<T>(_ cellType: T.Type) where T: NibTableViewCell {
        register(cellType.nib, forCellReuseIdentifier: cellType.className)
    }

    func dequeueReusableCell<T>(_ cellType: T.Type, for indexPath: IndexPath) -> T where T: NibTableViewCell {
        let anyCell = dequeueReusableCell(withIdentifier: cellType.className, for: indexPath)

        guard let cell = anyCell as? T else {
            fatalError("Unexpected cell type \(anyCell)")
        }
        return cell
    }
}
