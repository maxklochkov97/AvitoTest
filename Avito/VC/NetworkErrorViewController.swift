//
//  ErrorViewController.swift
//  Avito
//
//  Created by Максим Клочков on 04.05.2022.
//

import UIKit

class NetworkErrorViewController: UIViewController {

    private let networkErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Something wrong with your connection. Please try again."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    private let networkErrorImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "wifi.exclamationmark"))
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .gray
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    @objc private func tapAction() {
        self.dismiss(animated: true)
    }

    private func layout() {
        self.view.backgroundColor = .white
        [networkErrorImageView, networkErrorLabel].forEach({view.addSubview($0)})

        let offset: CGFloat = 16

        NSLayoutConstraint.activate([
            networkErrorImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            networkErrorImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            networkErrorImageView.widthAnchor.constraint(equalToConstant: 100),
            networkErrorImageView.heightAnchor.constraint(equalTo: networkErrorImageView.widthAnchor, multiplier: 0.8),

            networkErrorLabel.topAnchor.constraint(equalTo: networkErrorImageView.bottomAnchor, constant: offset),
            networkErrorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: offset),
            networkErrorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -offset)
        ])
    }
}
