//
//  ViewController.swift
//  ThreeButtons
//
//  Created by Efimenko Vyacheslav Sergeevich on 05.07.2023.
//

import UIKit

class ViewController: UIViewController {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews:
                [
                    MyAmazingButtonView(title: "First button"),
                    MyAmazingButtonView(title: "Second medium button"),
                    MyAmazingButtonView(title: "Third") { [weak self] in
                        guard let self else { return }

                        self.updateButtonsStyle()
                        self.presentModalVC()
                    }
                ]
        )
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()

    private func presentModalVC() {
        let vc = ModalViewController()
        vc.completion = updateButtonsStyle
        vc.view.backgroundColor = .red
        present(vc, animated: true, completion: nil)
    }

    private func updateButtonsStyle() {
        if let buttons = stackView.arrangedSubviews.filter({ $0 is MyAmazingButtonView }) as? [MyAmazingButtonView] {
            buttons.forEach {
                $0.changeButtonStyle()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
            [
                stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
    }
}
