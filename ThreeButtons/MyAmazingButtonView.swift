//
//  MyAmazingButtonView.swift
//  ThreeButtons
//
//  Created by Efimenko Vyacheslav Sergeevich on 05.07.2023.
//

import UIKit

enum MyAmazingButtonStyle {
    case systemBlue
    case gray
}

final class MyAmazingButtonView: UIButton {
    private let title: String
    private let action: (() -> Void)?
    private lazy var style: MyAmazingButtonStyle = .systemBlue {
        didSet {
            switch style {
            case .systemBlue:
                backgroundColor = .systemBlue
            case .gray:
                backgroundColor = .gray
            }
        }
    }

    init(title: String, action: (() -> Void)? = nil, frame: CGRect = .zero) {
        self.title = title
        self.action = action
        super.init(frame: frame)
        self.setupContentConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeButtonStyle() {
        switch style {
        case .systemBlue:
            style = .gray
        case .gray:
            style = .systemBlue
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        transformButton(touches, transform: .init(scaleX: 0.85, y: 0.85))
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        transformButton(touches, transform: .identity, completion: action)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        transformButton(touches, transform: .identity, completion: action)
    }

    private func transformButton(
        _ touches: Set<UITouch>,
        transform: CGAffineTransform,
        completion: (() -> Void)? = nil
    ) {
        if let touch = touches.first, touch.view == self {
            UIView.animate(withDuration: 0.15, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction]) {
                self.transform = transform
            }
            completion?()
        }
    }

    private func configure() {
        setupContentConfiguration()
    }

    private func setupContentConfiguration() {
        contentEdgeInsets = .init(top: 10, left: 14, bottom: 10, right: 14)
        semanticContentAttribute = .forceRightToLeft
        setImage(UIImage(systemName: "arrow.right.circle.fill"), for: .normal)
        imageView?.tintColor = .white
        imageEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 0)
        adjustsImageWhenHighlighted = false
        backgroundColor = .systemBlue
        layer.cornerRadius = 7
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
    }    
}
