import Firebase
import SwiftUI

struct CommunityView: View {
    @State private var newPost: String = ""
    @State private var community = [CommunityModel]() // Renamed posts to community
    @State private var validationMessage: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    
    @EnvironmentObject var session: SessionManager // Assuming SessionManager stores user's information
    
    var body: some View {
        VStack {
            Text("Comunidad de Apoyo")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.black)

            // Caja de texto para escribir la publicación
            TextField("Cuéntanos tu experiencia...", text: $newPost)
                .padding(10)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 5)
                .frame(maxWidth: .infinity, minHeight: 100)
                .onChange(of: newPost) { newValue in
                    if !newValue.isEmpty {
                        validationMessage = validatePostContent(newValue)
                    } else {
                        validationMessage = ""
                    }
                }

            // Mostrar mensaje de validación
            if !newPost.isEmpty && !validationMessage.isEmpty {
                Text(validationMessage)
                    .foregroundColor(.red)
                    .padding(.top, 2)
            }

            Button(action: {
                if isPostValid() {
                    let username = session.username ?? "Usuario Desconocido"  // Use the actual username from the session
                    let post = CommunityModel(id: UUID().uuidString, username: username, content: newPost, likes: 0, hasLiked: false, date: formatDate(Date()))
                    savePostToFirebase(post: post)  // Save to Firebase
                    community.insert(post, at: 0)  // Insert into community array
                    newPost = ""
                    alertMessage = "Gracias por compartir tus pensamientos."
                    showAlert = true
                }
            }) {
                Text("Publicar")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isPostValid() ? Color.green : Color.gray)
                    .cornerRadius(5)
            }
            .disabled(!isPostValid())
            .padding()

            Text("Total de publicaciones: \(community.count)") // Update to community
                .font(.headline)
                .padding(.bottom)
                .foregroundColor(.black)

            ScrollView {
                VStack {
                    ForEach(community.sorted { $0.date > $1.date }) { post in // Update to community
                        PostView(
                            post: post,
                            onLike: { updatedPost in
                                if let index = community.firstIndex(where: { $0.id == updatedPost.id }) { // Update to community
                                    community[index] = updatedPost
                                }
                                updateLikesInFirebase(post: updatedPost)
                            },
                            onDelete: { deletedPost in
                                deletePostFromFirebase(post: deletedPost)
                                community.removeAll { $0.id == deletedPost.id } // Update to community
                            }
                        )
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .padding()
        .background(Color.pink.opacity(0.2).edgesIgnoringSafeArea(.all))
        .overlay(
            VStack {
                if showAlert {
                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.green)
                        
                        Text(alertMessage)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                        
                        Button(action: { showAlert = false }) {
                            Text("Gracias por participar")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding(40)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .frame(maxWidth: 300)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
                }
            }
            .animation(.spring(), value: showAlert)
        )
        .onAppear {
            loadPostsFromFirebase() // Cargar las publicaciones cuando la vista aparece
        }
    }

    // Función para cargar publicaciones desde Firebase
    func loadPostsFromFirebase() {
        let ref = Database.database().reference().child("community") // Firebase reference to 'community'
        
        ref.observe(.value) { snapshot in
            var posts: [CommunityModel] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let postDict = snapshot.value as? [String: Any] {
                    let post = CommunityModel(snapshot: snapshot)
                    posts.append(post)
                }
            }
            community = posts.sorted { $0.date > $1.date } // Ordena las publicaciones por fecha
        }
    }

    // Función para validar contenido
    func validatePostContent(_ content: String) -> String {
        let filteredContent = content.filter { $0.isLetter }
        if hasSequentialRepeatingLetters(filteredContent) {
            return "No se permiten letras repetidas más de dos veces consecutivas."
        }
        let charCount = filteredContent.count
        if charCount < 10 {
            return "Tu publicación debe tener al menos 10 caracteres (sin contar espacios)."
        } else if charCount > 2000 {
            return "Tu publicación no puede tener más de 2000 caracteres."
        } else {
            return ""
        }
    }

    func hasSequentialRepeatingLetters(_ content: String) -> Bool {
        if content.count >= 2,
           let lastChar = content.last,
           let secondLastChar = content.dropLast().last {
            return lastChar == secondLastChar
        }
        return false
    }

    func isPostValid() -> Bool {
        let filteredContent = newPost.filter { $0.isLetter }
        let charCount = filteredContent.count
        return charCount >= 10 && charCount <= 2000 && !hasSequentialRepeatingLetters(filteredContent)
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }

    // Guardar en Firebase
    func savePostToFirebase(post: CommunityModel) {
        let ref = Database.database().reference().child("community").child(post.id) // Updated Firebase reference
        ref.setValue(post.toDictionary())
    }

    // Eliminar de Firebase
    func deletePostFromFirebase(post: CommunityModel) {
        let ref = Database.database().reference().child("community").child(post.id) // Updated Firebase reference
        ref.removeValue { error, _ in
            if let error = error {
                print("Error al eliminar: \(error.localizedDescription)")
            } else {
                print("Publicación eliminada correctamente.")
            }
        }
    }

    func onLike(updatedPost: CommunityModel) {
        // Actualizar el arreglo local
        if let index = community.firstIndex(where: { $0.id == updatedPost.id }) {
            community[index] = updatedPost
        }
        
        // Actualizar Firebase con los cambios de likes, hasLiked y likedUsers
        updateLikesInFirebase(post: updatedPost)
    }

    func updateLikesInFirebase(post: CommunityModel) {
        let ref = Database.database().reference().child("community").child(post.id)
        ref.updateChildValues([
            "likes": post.likes,
            "hasLiked": post.hasLiked,
            "likedUsers": post.likedUsers // Guardar lista de usuarios que dieron "like"
        ])
    }

}



struct PostView: View {
    var post: CommunityModel
    var onLike: (CommunityModel) -> Void
    var onDelete: (CommunityModel) -> Void
    
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(post.username ?? "Usuario")")
                .font(.headline)
                .foregroundColor(.purple)
            
            Text(post.content)
                .font(.body)
                .foregroundColor(.black)
                .padding(.top, 5)
            
            HStack {
                // Validar si el usuario ya ha dado "Te apoyo"
                Button(action: {
                    if !post.likedUsers.contains(session.username ?? "") { // Si el usuario no ha dado "like"
                        var updatedPost = post
                        updatedPost.likes += 1 // Incrementar solo una vez
                        updatedPost.likedUsers.append(session.username ?? "") // Añadir usuario a la lista
                        updatedPost.hasLiked = true // Marcar como "liked"
                        onLike(updatedPost) // Llamar a la función onLike para actualizar la publicación
                    }
                }) {
                    Image(systemName: post.hasLiked ? "heart.fill" : "heart")
                        .foregroundColor(post.hasLiked ? .red : .gray)
                }
                
                // Mostrar el número de "Te apoyo"
                Text("\(post.likes) Te apoyo")
                    .foregroundColor(.blue)
                
                Spacer()
                
                // Mostrar botón de eliminar solo si el usuario es el autor
                if post.username == session.username {
                    Button(action: { onDelete(post) }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
            .padding(.top, 10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 5)
    }
}

