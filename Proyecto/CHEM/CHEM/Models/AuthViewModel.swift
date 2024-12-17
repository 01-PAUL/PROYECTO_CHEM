import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var errorMessage: String?
    @Published var isRegistrationSuccessful = false

    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                completion(false)
                return
            }
            DispatchQueue.main.async {
                self?.isLoggedIn = true
                completion(true)
            }
        }
    }

    func register(email: String, username: String, password: String) {
        guard !email.isEmpty, !username.isEmpty, !password.isEmpty else {
            self.errorMessage = "Todos los campos son obligatorios"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
            
            // Usuario registrado con éxito
            self?.isRegistrationSuccessful = true
            
            // Actualizar el perfil del usuario con el nombre de usuario
            if let user = authResult?.user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = username
                
                changeRequest.commitChanges { error in
                    if let error = error {
                        self?.errorMessage = error.localizedDescription
                    } else {
                        print("Nombre de usuario actualizado")
                    }
                }
            }
        }
    }
}
