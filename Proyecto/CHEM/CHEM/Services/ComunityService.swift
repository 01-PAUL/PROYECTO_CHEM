//
//  ComunityService.swift
//  CHEM
//
//  Created by DAMII on 17/12/24.
//

import Foundation
import FirebaseDatabase

class CommunityViewModel: ObservableObject {
    private var databaseRef: DatabaseReference

    init() {
        // Inicializa la referencia a Firebase Realtime Database
        self.databaseRef = Database.database().reference()
    }

    func savePost(post: CommunityModel) {
        let postRef = databaseRef.child("comunity").childByAutoId()
        postRef.setValue(post.toDictionary()) { error, ref in
            if let error = error {
                print("Error al guardar la publicación: \(error.localizedDescription)")
            } else {
                print("Publicación guardada correctamente")
            }
        }
    }
}
