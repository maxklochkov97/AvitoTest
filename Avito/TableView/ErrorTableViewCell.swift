//
//  Error.swift
//  Avito
//
//  Created by Максим Клочков on 05.05.2022.
//

import UIKit

class ErrorTableViewCell: UITableViewCell {

    private let errorTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.text = "Server is temporarily unavailable.  Please try again later."
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        self.contentView.backgroundColor = .red
        [errorTextLabel].forEach { contentView.addSubview($0) }

        let offset: CGFloat = 16

        NSLayoutConstraint.activate([
            errorTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: offset),
            errorTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            errorTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            errorTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -offset)
        ])
    }
}
