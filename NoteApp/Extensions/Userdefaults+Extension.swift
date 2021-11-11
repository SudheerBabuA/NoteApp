//
//  UserdefaultsExtension.swift
//  NoteApp
//
//  Created by Avudari Sudheer Babu on 18/10/21.
//

import Foundation

// 
extension UserDefaults {
    private enum UserdefaultsKeys: String {
        case hasOnboarded
    }
    var hasOnboarded: Bool {
        get {
            bool(forKey: UserdefaultsKeys.hasOnboarded.rawValue)
        }
        set {
            setValue(newValue, forKey: UserdefaultsKeys.hasOnboarded.rawValue)
        }
    }
}
