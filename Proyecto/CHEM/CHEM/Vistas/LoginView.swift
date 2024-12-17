import SwiftUI

struct LoginView: View {
    @State private var username: String = "Paul@gmail.com"
    @State private var password: String = "123456"
    @State private var isPasswordVisible: Bool = false
    @StateObject private var authViewModel = AuthViewModel()
    @EnvironmentObject var session : SessionManager
    
    var body: some View {
        VStack {
            // Logo de la app o título grande
            Image(systemName: "hand.raised.slash") // Ícono de la mano prohibida
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
                .padding(.top, 50)
            
            Text("Bienvenida")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 10)
            
            Text("Inicia sesión para acceder a tus recursos de apoyo")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.top, 5)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            // Campos de texto para usuario y contraseña
            VStack(spacing: 16) {
                TextField("Usuario", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal, 30)
                
                ZStack {
                    if isPasswordVisible {
                        TextField("Contraseña", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.horizontal, 30)
                    } else {
                        SecureField("Contraseña", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding(.horizontal, 30)
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 35)
                        }
                    }
                }
            }
            
            // Botón para iniciar sesión
            Button(action: {
                authViewModel.login(email: username, password: password) { success in
                    if success {
                        session.login()
                    }
                }
                
              
            }) {
                Text("Iniciar Sesión")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.pink)
                    .cornerRadius(10)
                    .padding(.top, 20)
                    .padding(.horizontal, 30)
            }
            
            
            // Texto para ir a la pantalla de registro
            HStack {
                Text("¿No tienes cuenta?")
                    .foregroundColor(.white)
                NavigationLink(destination: RegisterView()) {
                    Text("Regístrate")
                        .foregroundColor(.pink)
                        .fontWeight(.bold)
                }
            }
            .padding(.top, 20)
            
            Spacer()
        }
            .background(LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.8), Color.purple.opacity(0.8)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
