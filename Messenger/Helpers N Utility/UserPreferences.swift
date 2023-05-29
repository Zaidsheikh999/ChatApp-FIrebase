//
//  UserPreferences.swift
//  Messenger
//
//  Created by Zaid Sheikh on 29/05/2023.
//

import Foundation


class UserPreferences {
    
    class var isLoggedIn:Bool{
        get{
            let userDefaults:UserDefaults = UserDefaults.standard;
            
            if let at:Bool = userDefaults.object(forKey: "is_logged_in") as? Bool {
                return at
            }
            return false
        }
        set{
            let userDefaults:UserDefaults = UserDefaults.standard;
            userDefaults.set(newValue, forKey: "is_logged_in")
            userDefaults.synchronize();
        }
    }

}
