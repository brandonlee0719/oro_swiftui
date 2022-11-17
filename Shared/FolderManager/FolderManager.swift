//
//  FolderManager.swift
//  ORO (iOS)
//
//  Created by MAC on 2022/11/17.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseDatabase

class FolderManager: NSObject,ObservableObject {
    override init() {
        super.init()
        observableListObject()
    }
    
    @Published var listFolders = [FolderModal]()
    @Published var value: String? = nil
    
    var ref = Database.database().reference()
    
    func readValue() {
        ref.child("folder").observeSingleEvent(of: .value) { snapshot in
            self.value = snapshot.value as? String ?? "Load failed"
        }
    }

    func observerDataChange() {
        ref.child("test").observe(.value) { snapshot in
            self.value = snapshot.value as? String ?? "Load failed"
        }
    }

    func pushObject(title: String, updatedAt: String, security: String, records: String) {
        var generatedObject = FolderModal()
        generatedObject.title = title
        generatedObject.updatedAt = updatedAt
        generatedObject.security = security
        generatedObject.records = records

        ref.child("folder/\(LocalStorage.uidValue)/\(generatedObject.id)").setValue(generatedObject.toDictionary)
    }
    
    func observableListObject() {
        ref.child("folder/\(LocalStorage.uidValue)").observeSingleEvent(of: .value) { snapshot in
            for case let child as DataSnapshot in snapshot.children {
                guard let dict = child.value as? [String:Any] else {
                    print("Error")
                    return
                }
                let title =  dict["title"] as! String
                let updatedAt =  dict["updatedAt"] as! String
                let security =  dict["security"] as! String
                let records =  dict["records"] as! String
                self.listFolders.append(FolderModal(title: title, updatedAt: updatedAt, security: security, records: records))
            }
        }
        
    }
}
