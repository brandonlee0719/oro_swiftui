//
//  LocalStorage.swift
//  ORO (iOS)
//
//  Created by MAC on 2022/11/16.
//

import Foundation
 
class LocalStorage {
     
    private static let uidKey: String = "uID"
     
    public static var uidValue: String {
        set {
            UserDefaults.standard.set(newValue, forKey: uidKey)
        }
        get {
            return UserDefaults.standard.string(forKey: uidKey) ?? ""
        }
    }
     
    public static func removeValue() {
        UserDefaults.standard.removeObject(forKey: uidKey)
    }
     
}
