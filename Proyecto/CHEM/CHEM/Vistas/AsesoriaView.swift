//
//  AsesoriaView.swift
//  CHEM
//
//  Created by DAMII on 30/11/24.
//

import SwiftUI

struct AsesoriaView: View {
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var showAlert: Bool = false
    @State private var isRequestSent: Bool = false
    
    var body: some View {
        VStack {
            // Título
            Text("Asesoría")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.pink)
                .padding(.top, 40)
            
            Text("Recibe ayuda personalizada de nuestros especialistas.")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.horizontal, 20)
            
            // Formulario de solicitud
            VStack(spacing: 20) {
                
                // Nombre
                TextField("Nombre Completo", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                
                // Número de teléfono
                TextField("Número de Teléfono", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                
                // Correo Electrónico
                TextField("Correo Electrónico", text: $email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                
                // Mensaje
                TextEditor(text: $message)
                    .frame(height: 150)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                
                // Botón de Enviar Solicitud
                Button(action: {
                    if validateFields() {
                        // Enviar la solicitud (aquí puedes hacer una acción como llamar a una API)
                        isRequestSent = true
                    } else {
                        showAlert.toggle()
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
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Por favor, completa todos los campos."), dismissButton: .default(Text("Aceptar")))
                }
            }
            .padding(.top, 30)
            
            // Mensaje de éxito cuando la solicitud es enviada
            if isRequestSent {
                Text("¡Solicitud Enviada Exitosamente!")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
            }
            
            Spacer()
        }
        .background(Color.pink.opacity(0.1).edgesIgnoringSafeArea(.all))
    }
    
    // Función de validación de los campos
    func validateFields() -> Bool {
        return !name.isEmpty && !phoneNumber.isEmpty && !email.isEmpty && !message.isEmpty
    }
}

struct PersonalizedAssistanceView_Previews: PreviewProvider {
    static var previews: some View {
        AsesoriaView()
    }
}
