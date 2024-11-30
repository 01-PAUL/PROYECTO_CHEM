import SwiftUI

struct RegisterView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                // Logo de la app o título grande
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
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal, 30)

                    TextField("Correo electrónico", text: $email)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal, 30)

                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal, 30)

                    SecureField("Confirmar Contraseña", text: $confirmPassword)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal, 30)
                }
                
                // Botón para crear cuenta
                Button(action: {
                    // Acción para registrar la cuenta
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

                // Texto para ir a la pantalla de inicio de sesión
                HStack {
                    Text("¿Ya tienes cuenta?")
                        .foregroundColor(.white)
                    NavigationLink(destination: LoginView()) {
                        Text("Inicia sesión")
                            .foregroundColor(.pink)
                            .fontWeight(.bold).onTapGesture {
                                dismiss()
                            }
                        
                        
                    }
                }
                .padding(.top, 20)
                
                Spacer()
            }
        }
        
        .background(LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.8), Color.purple.opacity(0.8)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
