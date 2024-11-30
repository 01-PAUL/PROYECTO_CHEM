//
//  EmergencyView.swift
//  CHEM
//
//  Created by DAMII on 30/11/24.
//

import SwiftUI

struct EmergencyView: View {
    @State private var familyNumber: String = ""  // Número de contacto de emergencia
    @State private var showAlert: Bool = false  // Para mostrar alerta si el número está vacío
    @State private var isEmergencyAlertVisible: Bool = false  // Notificación de emergencia a familiares
    @State private var emergencyMessageSent = false  // Para gestionar el estado de envío del mensaje
    
    var body: some View {
        VStack(spacing: 30) {
            // Título y descripción
            Text("¡Emergencia!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 40)
            
            Text("Llama a emergencias o notifica a tus contactos.")
                .font(.body)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
            
            Spacer()
            
            // Llamar a emergencias (Policía)
            Button(action: {
                callEmergencyNumber(number: "105")  // Llamada directa a la policía
            }) {
                Text("Llamar a la Policía")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(15)
                    .shadow(radius: 10)
            }
            .padding(.horizontal, 20)
            
            // Ingresar número de familiar para enviar mensaje
            VStack {
                TextField("Número de Familiar", text: $familyNumber)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)
                
                Button(action: {
                    sendEmergencyMessage()
                }) {
                    Text("Enviar Mensaje de Emergencia")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(familyNumber.isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 20)
                .disabled(familyNumber.isEmpty)  // Deshabilitar si no se ingresa un número
            }
            
            // Botón de Notificar Emergencia (alerta a familiares)
            Button(action: {
                self.isEmergencyAlertVisible.toggle()  // Activar la notificación de emergencia
                sendEmergencyAlert()
            }) {
                Text("Notificar Emergencia")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.pink)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 20)
            .alert(isPresented: $isEmergencyAlertVisible) {
                Alert(
                    title: Text("¡Emergencia Notificada!"),
                    message: Text("Se ha enviado una alerta a las autoridades y a tus familiares."),
                    dismissButton: .default(Text("Aceptar"))
                )
            }
            
            Spacer()
        }
        .background(Color.pink.opacity(0.9).edgesIgnoringSafeArea(.all))  // Fondo de emergencia
        .onAppear {
            // Restablecer el estado de la notificación
            emergencyMessageSent = false
        }
    }
    
    // Función para llamar a un número de emergencia (Ej: Policía)
    func callEmergencyNumber(number: String) {
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    // Función para enviar un mensaje de emergencia
    func sendEmergencyMessage() {
        if !familyNumber.isEmpty {
            let message = "¡Estoy en emergencia! Por favor ayuda, estoy en peligro."
            if let url = URL(string: "sms:\(familyNumber)&body=\(message)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                emergencyMessageSent = true
                showAlert = true
            }
        } else {
            showAlert = true  // Si el número está vacío, muestra una alerta
        }
    }
    
    // Función para notificar la emergencia a contactos predefinidos
    func sendEmergencyAlert() {
        // Lógica para notificar la emergencia a los contactos (como enviar un SMS a los familiares)
        let emergencyMessage = "¡Estoy en una emergencia! Necesito ayuda inmediatamente. Estoy en peligro."
        let familyContacts = ["+51XXXXXXXXX", "+51XXXXXXXXX"]  // Ejemplo de contactos predefinidos (puedes agregar más)
        
        for contact in familyContacts {
            if let url = URL(string: "sms:\(contact)&body=\(emergencyMessage)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}

struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyView()
    }
}
