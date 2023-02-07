//
//  UserPreferences.swift
//  CallAPIExample
//
//  Created by Leo Ho on 2023/2/6.
//

import Foundation

class UserPreferences: NSObject {
    
    static let shared = UserPreferences()
    
    enum Keys: String {
        case lastSearchNum
    }
    
    var lastSearchNum: String {
        get { return UserDefaults.standard.string(forKey: Keys.lastSearchNum.rawValue) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: Keys.lastSearchNum.rawValue) }
    }
}
