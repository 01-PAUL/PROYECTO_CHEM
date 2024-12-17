//
//  ComunityModel.swift
//  CHEM
//
//  Created by DAMII on 17/12/24.
//

import Foundation
import Firebase
import SwiftUI

struct CommunityModel: Identifiable {
    var id: String
    var username: String?
    var content: String
    var likes: Int
    var hasLiked: Bool
    var date: String
    var likedUsers: [String] // Lista de IDs de usuarios que han dado "like"
    
    init(id: String, username: String, content: String, likes: Int, hasLiked: Bool, date: String, likedUsers: [String] = []) {
        self.id = id
        self.username = username
        self.content = content
        self.likes = likes
        self.hasLiked = hasLiked
        self.date = date
        self.likedUsers = likedUsers
    }
    
    // Para convertir a diccionario y guardar en Firebase
    func toDictionary() -> [String: Any] {
        return [
            "username": username ?? "",
            "content": content,
            "likes": likes,
            "hasLiked": hasLiked,
            "date": date,
            "likedUsers": likedUsers
        ]
    }
    
    init(snapshot: DataSnapshot) {
        let value = snapshot.value as! [String: Any]
        self.id = snapshot.key
        self.username = value["username"] as? String ?? ""
        self.content = value["content"] as? String ?? ""
        self.likes = value["likes"] as? Int ?? 0
        self.hasLiked = value["hasLiked"] as? Bool ?? false
        self.date = value["date"] as? String ?? ""
        self.likedUsers = value["likedUsers"] as? [String] ?? []
    }
}

