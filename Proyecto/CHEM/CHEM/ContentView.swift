//
//  ContentView.swift
//  CHEM
//
//  Created by DAMII on 30/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var session = SessionManager()
    
    var body: some View {
        if session.isLogged{
            MainMenuView().environment(session)
        }else{
            LoginView().environment(session)
        }
    }
}

#Preview {
    ContentView()
}
