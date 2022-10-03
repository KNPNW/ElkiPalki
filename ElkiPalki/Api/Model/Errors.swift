//
//  Errors.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 03.09.2022.
//

import Foundation

struct Errors: Codable {
    let message: String
    let errors: [error]
}

struct error: Codable {
    let value: String
    let msg: String
    let param: String
    let location: String
}
