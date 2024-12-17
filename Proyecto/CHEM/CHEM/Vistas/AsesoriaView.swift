import Firebase
import SwiftUI

struct AsesoriaView: View {
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var address: String = "" // Optional field

    @State private var nameError: String? = nil
    @State private var phoneError: String? = nil
    @State private var emailError: String? = nil
    @State private var messageError: String? = nil
    @State private var addressError: String? = nil
    
    @State private var showSuccessMessage = false // Variable to control success message

    var body: some View {
        ZStack {
            VStack {
                // Title and instructions
                Text("Asesoría")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                    .padding(.top, 40)

                Text("Recibe ayuda personalizada de nuestros especialistas.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)

                // Form
                VStack(spacing: 20) {
                    TextField("Nombre Completo", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                        .onChange(of: name) { _ in
                            name = String(name.prefix(50))
                            name = name.replacingOccurrences(of: "[^a-zA-Z ]", with: "", options: .regularExpression)
                            validateName()
                        }
                    if let nameError = nameError {
                        Text(nameError).errorStyle()
                    }

                    TextField("Número de Teléfono", text: $phoneNumber)
                        .keyboardType(.phonePad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                        .onChange(of: phoneNumber) { _ in
                            phoneNumber = String(phoneNumber.prefix(9))
                            phoneNumber = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
                            validatePhoneNumber()
                        }
                    if let phoneError = phoneError {
                        Text(phoneError).errorStyle()
                    }

                    TextField("Correo Electrónico", text: $email)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                        .onChange(of: email) { _ in
                            email = email.trimmingCharacters(in: .whitespaces)
                            validateEmail()
                        }
                    if let emailError = emailError {
                        Text(emailError).errorStyle()
                    }

                    TextField("Dirección (opcional)", text: $address)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)

                    TextEditor(text: $message)
                        .frame(height: 150)
                        .padding(10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        .onChange(of: message) { _ in
                            message = String(message.prefix(200))
                            validateMessage()
                        }
                    if let messageError = messageError {
                        Text(messageError).errorStyle()
                    }

                    Button(action: {
                        if validateFields() {
                            saveRequestToFirebase()
                            showSuccessMessage = true
                        }
                    }) {
                        Text("Enviar Solicitud")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.pink)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 30)

                Spacer()
            }
            .background(Color.pink.opacity(0.1).edgesIgnoringSafeArea(.all))

            // Success message
            if showSuccessMessage {
                VStack(spacing: 20) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.green)

                    Text("¡Solicitud Enviada!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    Text("Nos pondremos en contacto contigo.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 10)

                    Button(action: {
                        // Clear fields and close message
                        name = ""
                        phoneNumber = ""
                        email = ""
                        message = ""
                        address = ""
                        showSuccessMessage = false
                    }) {
                        Text("¡Perfecto!")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 150)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .frame(width: 300, height: 300)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
            }
        }
    }

    // Validate form fields
    func validateName() {
        nameError = name.count < 20 ? "Debe tener al menos 20 caracteres." : nil
    }
    func validatePhoneNumber() {
        phoneError = phoneNumber.count != 9 ? "Debe tener 9 dígitos." : nil
    }
    func validateEmail() {
        emailError = !email.hasSuffix("@gmail.com") ? "Debe terminar en @gmail.com" : nil
    }
    func validateMessage() {
        messageError = message.count < 20 ? "Mínimo 20 caracteres." : nil
    }
    func validateFields() -> Bool {
        validateName()
        validatePhoneNumber()
        validateEmail()
        validateMessage()
        return nameError == nil && phoneError == nil && emailError == nil && messageError == nil
    }

    // Save request to Firebase
    func saveRequestToFirebase() {
        let ref = Database.database().reference().child("asesorias") // Firebase reference to "asesorias"
        
        // Si la dirección está vacía, asigna "No especificado"
        let finalAddress = address.isEmpty ? "No especificado" : address
        
        let request = [
            "name": name,
            "phoneNumber": phoneNumber,
            "email": email,
            "message": message,
            "address": finalAddress,
            "timestamp": getCurrentDateTime()
        ] as [String : Any]
        
        ref.childByAutoId().setValue(request) { error, _ in
            if let error = error {
                print("Error saving request: \(error.localizedDescription)")
            } else {
                print("Request saved successfully")
            }
        }
    }

    // Función para obtener la fecha y hora local en formato "yyyy-MM-dd HH:mm:ss"
    func getCurrentDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDate = Date()
        return formatter.string(from: currentDate)
    }

}

extension View {
    func errorStyle() -> some View {
        self
            .font(.caption)
            .foregroundColor(.red)
            .padding(.horizontal, 20)
    }
}
