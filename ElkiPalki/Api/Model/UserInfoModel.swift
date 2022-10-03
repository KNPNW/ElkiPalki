//
//  UserInfoModel.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 14.09.2022.
//

import Foundation

final class UserInfoModel: Codable {
    var refreshToken: String
    var userFirstName: String
    var userLastName: String
    var userDateBirthday: String
    var userPhone: String
    
    init(refreshToken: String, userFirstName: String, userLastName: String, userDateBirthday: String, userPhone: String) {
        self.refreshToken = refreshToken
        self.userFirstName = userFirstName
        self.userLastName = userLastName
        self.userDateBirthday = userDateBirthday
        self.userPhone = userPhone
    }
}
