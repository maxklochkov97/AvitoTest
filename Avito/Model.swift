//
//  Model.swift
//  Avito
//
//  Created by Максим Клочков on 03.05.2022.
//

import Foundation

struct Avito: Decodable {
    let company: Company
}

struct Company: Decodable {
    let name: String
    let employees: [Employer]
}

struct Employer: Decodable {
    var name: String
    var phoneNumber: String
    var skills: [String]

    private enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}

