//
//  dataModel.swift
//  DragonBallHeroes
//
//  Created by Rocio Martos on 14/1/24.
//

import Foundation

struct AlternateLocalDataModel {
    private static let tokenKey = "AlternateDBToken"
    
    static func getToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    static func save(token: String) {
        guard !checkToken() else {
            return // Evitar guardar si ya hay un token
        }
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    static func deleteToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
    static func checkToken() -> Bool {
        return UserDefaults.standard.string(forKey: tokenKey) != nil
    }
}
