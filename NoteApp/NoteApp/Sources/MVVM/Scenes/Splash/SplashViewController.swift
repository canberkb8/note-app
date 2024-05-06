//
//  SplashViewController.swift
//  NoteApp
//
//  Created by definex_mobile2 on 3.05.2024.
//

import UIKit

final class SplashViewController: BaseViewController {
    private var router = SplashRouter()
    private let splashUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "definex")
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let splashImageMargin: CGFloat = 30
    private let animationTime: CGFloat = 2.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension SplashViewController {
    private func setup() {
        router.viewController = self
        setupUI()
        fadeAnimataion()
    }

    private func setupUI() {
        makeSplashImageView()
    }

    private func makeSplashImageView() {
        view.addSubview(splashUIImageView)
        NSLayoutConstraint.activate([
            splashUIImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: splashImageMargin),
            splashUIImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -splashImageMargin),
            splashUIImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            splashUIImageView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: splashImageMargin),
            splashUIImageView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -splashImageMargin)
            ])
    }

    private func fadeAnimataion() {
        UIView.animate(withDuration: animationTime) {
            self.splashUIImageView.alpha = 1
        } completion: { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.background(delay: 1.0, completion:{
                self.router.route(identifier: .dashboardViewController)
            })
        }
    }
}

