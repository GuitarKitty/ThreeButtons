//
//  ModalViewController.swift
//  ThreeButtons
//
//  Created by Efimenko Vyacheslav Sergeevich on 06.07.2023.
//

import UIKit

final class ModalViewController: UIViewController {
    lazy var completion: (() -> Void)? = nil {
        didSet {
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(swipe))
            view.addGestureRecognizer(panGestureRecognizer)
        }
    }

    @objc
    private func swipe(_ panGestureRecognizer: UIPanGestureRecognizer) {
        var initialOffset: CGFloat = 0
        let translation = panGestureRecognizer.translation(in: view).y
        let velocity = panGestureRecognizer.velocity(in: view).y
        let viewHeight = view.frame.height

        switch panGestureRecognizer.state {
        case .began:
            initialOffset = translation
        case .changed:
            UIView.animate(withDuration: 0.1) {
                self.view.frame.origin.y = (min(max(initialOffset + translation, 0), viewHeight))
            }
        case .ended, .cancelled:
            if velocity > 50 {
                dismiss(animated: true)
                completion?()
            } else {
                handleLowVelocitySwipe(with: translation)
            }
        default: break
        }
    }

    private func handleLowVelocitySwipe(with translation: CGFloat) {
        if translation >= view.frame.height * 0.6 {
            dismiss(animated: true)
            completion?()
        } else {
            UIView.animate(withDuration: 0.2) {
                self.view.frame.origin.y = 0
            }
        }
    }
}
