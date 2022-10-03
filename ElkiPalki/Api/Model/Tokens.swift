//
//  Tokens.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 02.09.2022.
//

struct Tokens: Codable {
    let tokens: token
}

struct token: Codable {
    let refreshToken: String
    let accessToken: String
}


//final class Tokens: Codable {
//    var refreshToken: String
//    var accessToken: String
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        refreshToken = try container.decode(String.self, forKey: .refreshToken)
//        accessToken = try container.decode(String.self, forKey: .accessToken)
//    }
//}
