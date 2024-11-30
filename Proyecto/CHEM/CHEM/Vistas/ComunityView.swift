import SwiftUI

struct CommunityView: View {
    @State private var newPost: String = ""

    var body: some View {
            VStack {
                Text("Comunidad de Apoyo")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                TextField("Escribe tu experiencia...", text: $newPost)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 5)
                
                Button(action: {
                    // Acción de publicar
                }) {
                    Text("Publicar")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()
                
                // Lista de publicaciones
                ScrollView {
                    VStack {
                        ForEach(0..<10, id: \.self) { _ in
                            PostView()
                        }
                    }
                }
            }
        
        .padding()
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
    }
}

struct PostView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Nombre de Usuario")
                .font(.headline)
                .foregroundColor(.purple)
            Text("Texto de la publicación...")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top, 5)
            
            HStack {
                Button(action: {
                    // Acción de reaccionar
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
                Text("Me gusta")
                    .foregroundColor(.blue)
                    .padding(.leading, 5)
            }
            .padding(.top, 10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.bottom, 10)
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
