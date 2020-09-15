//
//  UIWindow+extension.swift
//  TopMoviePlayer
//
//  Created by Sergei Popyvanov on 15.09.2020.
//  Copyright © 2020 Sergey Popyvanov. All rights reserved.
//

import UIKit

import UIKit

extension UIWindow {

    /// Устанавливает новый root view controller с плавной анимацией для активного окна
    class func keyWindowTransit(to viewController: UIViewController) {
        UIApplication.shared.keyWindow?.transit(to: viewController)
    }

    private func transit(to viewController: UIViewController) {
        let snapshotView = self.snapshotView(afterScreenUpdates: false)
        guard let snapshot = snapshotView else {
            self.rootViewController = viewController
            return
        }
        viewController.view.addSubview(snapshot)
        self.rootViewController = viewController

        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
            snapshot.layer.opacity = 0
            snapshot.layer.transform = CATransform3DMakeScale(1.25, 1.25, 1.25)
        }
        animator.addCompletion { position in
            guard position == .end else {
                return
            }
            snapshot.removeFromSuperview()
        }
        animator.startAnimation()
    }

}
