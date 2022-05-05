//
//  Model.swift
//  Avito
//
//  Created by Максим Клочков on 03.05.2022.
//

import Foundation

struct Server: Codable {
    var company: Company
}

struct Company: Codable {
    let name: String
    var employees: [Employee]
}

struct Employee: Codable {
    var name: String
    var phoneNumber: String
    var skills: [String]

    private enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}

