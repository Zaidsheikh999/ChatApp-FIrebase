//
//  DataBaseManager.swift
//  Messenger
//
//  Created by Zaid Sheikh on 30/05/2023.
//

import Foundation
import FirebaseDatabase

final class DataBaseManager{
    
    static let shared = DataBaseManager()
    
    private let database = Database.database().reference()
    
}

// MARK: - Database Management Methods

extension DataBaseManager{
    
    /// Validate is email exists
    public func isUserExist(with email: String, completion: @escaping ((Bool) -> Void)){
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    /// insert new user to database
    public func insertUser(with user: chatAppUser){
        database.child(user.email).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}

struct chatAppUser{
    let firstName: String
    let lastName: String
    let email: String
}
