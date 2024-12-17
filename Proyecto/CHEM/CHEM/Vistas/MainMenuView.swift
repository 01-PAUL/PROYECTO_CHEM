import SwiftUI

struct MainMenuView: View {
    
    @EnvironmentObject var session: SessionManager
        
        var body: some View {
            
            NavigationStack {
                VStack {
                    // Header con la bienvenida y foto de perfil
                    VStack {
                        HStack {
                            // Foto de perfil
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                                .padding(.leading, 15)
                            
                            VStack(alignment: .leading) {
                                Text("Hola, \(session.username ?? "Usuario")")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("Bienvenido a tu espacio de apoyo")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            }
                            .padding(.leading, 10)
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(15)
                        .padding(.top, 20)
                    }
                    
                    // Opciones principales del menú
                    VStack(spacing: 20) {
                        NavigationLink(destination: CommunityView()) {
                            MenuButtonView(title: "Unirte a la Comunidad", icon: "person.3.fill", color: .purple)
                        }
                        
                        NavigationLink(destination: ResourcesView()) {
                            MenuButtonView(title: "Recursos de Apoyo", icon: "book.fill", color: .blue)
                        }
                        
                        NavigationLink(destination: AsesoriaView()) {
                            MenuButtonView(title: "Contactar Especialistas", icon: "headphones.circle.fill", color: .orange)
                        }
                        
                        NavigationLink(destination: EmergencyView()) {
                            MenuButtonView(title: "Emergencia", icon: "exclamationmark.triangle.fill", color: .red)
                        }
                        NavigationLink(destination: EventoApoyoView()) {
                            MenuButtonView(title: "Eventos de Apoyo", icon: "person.crop.circle.fill", color: .green)
                        }
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                    
                    Text("Cerrar sesión")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 20).onTapGesture {
                            session.logout()
                        }
                    
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.8), Color.purple.opacity(0.8)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
            }
        }
    }

struct MenuButtonView: View {
    var title: String
    var icon: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.leading, 5)
            Spacer()
        }
        .padding()
        .background(color)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal, 30)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
