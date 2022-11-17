//
//  FolderModal.swift
//  ORO (iOS)
//
//  Created by MAC on 2022/11/17.
//

import Foundation

struct FolderModal: Encodable, Decodable {
    var id = UUID()
    var title: String = ""
    var updatedAt: String = ""
    var security: String = ""
    var records: String = ""
}

extension Encodable {
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    }
}
