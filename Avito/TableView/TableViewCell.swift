//
//  TableViewCell.swift
//  Avito
//
//  Created by Максим Клочков on 03.05.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    private let employeeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.text = "employeeNameLabel"
        return label
    }()

    private let employeePhoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.text = "employeePhoneLabel"
        return label
    }()

    private let employeeSkillsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "employeeSkillsLabel"
        return label
    }()

    private let labelVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        stack.spacing = 5
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(model: Employee) {
        self.employeeNameLabel.text = model.name
        self.employeePhoneLabel.text = model.phoneNumber
        self.employeeSkillsLabel.text = self.expandArrayToStringFrom(array: model.skills)
    }

    private func expandArrayToStringFrom(array: [String]) -> String {
        var string = ""
        for (index, skill) in array.enumerated() {
            if index < array.count - 1 {
                string += "\(skill)\n"
            } else {
                string += "\(skill)"
            }
        }
        return string
    }

    private func layout() {
        [labelVerticalStack].forEach { contentView.addSubview($0) }

        [employeeNameLabel, employeePhoneLabel, employeeSkillsLabel].forEach({ labelVerticalStack.addArrangedSubview($0) })

        let offset: CGFloat = 16

        NSLayoutConstraint.activate([
            labelVerticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: offset),
            labelVerticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            labelVerticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            labelVerticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -offset),

            employeeNameLabel.widthAnchor.constraint(equalTo: labelVerticalStack.widthAnchor, multiplier: 0.3),
            employeePhoneLabel.widthAnchor.constraint(equalTo: labelVerticalStack.widthAnchor, multiplier: 0.3),
            employeeSkillsLabel.widthAnchor.constraint(equalTo: labelVerticalStack.widthAnchor, multiplier: 0.3)
        ])
    }
}
