//
//  UserSettings.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 09.09.2022.
//

import Foundation

final class UserSettings {
    private enum SettingsKeys: String {
        case userEmail
        case userRefreshToken
        case isAuthorized
        case isFirstLaunch
    }
    
    static var userEmail: String! {
        get {
            UserDefaults.standard.string(forKey: SettingsKeys.userEmail.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userEmail.rawValue
            if let email = newValue {
                defaults.set(email, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var userRefreshToken: String! {
        get {
            UserDefaults.standard.string(forKey: SettingsKeys.userRefreshToken.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userRefreshToken.rawValue
            if let email = newValue {
                defaults.set(email, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var isAuthorized: Bool! {
        get {
            UserDefaults.standard.bool(forKey: SettingsKeys.isAuthorized.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.isAuthorized.rawValue
            if let value = newValue {
                defaults.set(value, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var isFirstLaunch: Bool! {
        get {
            UserDefaults.standard.bool(forKey: SettingsKeys.isFirstLaunch.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.isFirstLaunch.rawValue
            if let value = newValue {
                defaults.set(value, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
}
