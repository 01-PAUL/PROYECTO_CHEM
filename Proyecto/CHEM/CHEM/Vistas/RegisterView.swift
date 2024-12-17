import SwiftUI

struct RegisterView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showSuccessDialog = false
    @Environment(\.presentationMode) var presentationMode // Acceso al entorno para descartar vistas

    var body: some View {
        VStack {
            // Logo y título principal
            Image(systemName: "shield.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
                .padding(.top, 50)

            Text("Crea tu cuenta")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 10)

            Text("Únete para acceder a recursos y apoyo")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.top, 5)
                .multilineTextAlignment(.center)

            Spacer()

            // Campos de texto para usuario, email y contraseñas
            VStack(spacing: 16) {
                TextField("Nombre de usuario", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal, 30)

                TextField("Correo electrónico", text: $email)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal, 30)

                SecureField("Contraseña", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal, 30)

                SecureField("Confirmar Contraseña", text: $confirmPassword)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal, 30)
            }

            // Botón para crear cuenta
            Button(action: {
                authViewModel.register(email: email, username: username, password: password)
            }) {
                Text("Crear Cuenta")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.pink)
                    .cornerRadius(10)
                    .padding(.top, 20)
                    .padding(.horizontal, 30)
            }

            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
            }

            HStack {
                Text("¿Ya tienes cuenta?")
                    .foregroundColor(.white)
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Descartar la vista actual
                }) {
                    Text("Inicia sesión")
                        .foregroundColor(.pink)
                        .fontWeight(.bold)
                }
            }
            .padding(.top, 20)

            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.8), Color.purple.opacity(0.8)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .alert(isPresented: $authViewModel.isRegistrationSuccessful) {
            Alert(
                title: Text("Registro Exitoso"),
                message: Text("Bienvenido, \(username)!"),
                dismissButton: .default(Text("Aceptar"), action: {
                    showSuccessDialog = true
                })
            )
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
