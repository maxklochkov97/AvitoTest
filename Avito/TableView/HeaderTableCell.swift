//
//  HeaderTableCell.swift
//  Avito
//
//  Created by Максим Клочков on 03.05.2022.
//

import UIKit

class HeaderView: UIView {
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private let skillsLabel: UILabel = {
        let label = UILabel()
        label.text = "Skills"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private let labelHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(model: Company) {
        self.companyNameLabel.text = model.name
    }

    private func layout() {
        [companyNameLabel, labelHorizontalStack].forEach { self.addSubview($0) }

        [nameLabel, numberLabel, skillsLabel].forEach { labelHorizontalStack.addArrangedSubview($0) }


        let offset: CGFloat = 16

        NSLayoutConstraint.activate([
            companyNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: offset),
            companyNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: offset),
            companyNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -offset),

            labelHorizontalStack.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: offset),
            labelHorizontalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: offset),
            labelHorizontalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -offset),
            labelHorizontalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -offset),

            nameLabel.widthAnchor.constraint(equalTo: labelHorizontalStack.widthAnchor, multiplier: 0.3),
            numberLabel.widthAnchor.constraint(equalTo: labelHorizontalStack.widthAnchor, multiplier: 0.3),
            skillsLabel.widthAnchor.constraint(equalTo: labelHorizontalStack.widthAnchor, multiplier: 0.3)
        ])
    }

}
