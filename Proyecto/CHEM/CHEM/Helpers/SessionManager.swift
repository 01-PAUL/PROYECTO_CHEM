//
//  SessionManager.swift
//  CHEM
//
//  Created by DAMII on 3/12/24.
//

import Foundation
import FirebaseAuth

class SessionManager : ObservableObject, Observable {

    
    @Published var isLogged = false
    @Published var username: String? // Store the username here
    
    func login() {
        // Assume that you get the username from Firebase when the user logs in
        if let user = Auth.auth().currentUser {
            self.username = user.displayName // or fetch it from Firestore if stored there
            self.isLogged = true
        }
    }
    
    func logout() {
        try? Auth.auth().signOut()
        self.username = nil
        self.isLogged = false
    }
}
