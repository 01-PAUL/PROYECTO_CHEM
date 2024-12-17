import SwiftUI

struct EventoApoyoView: View {
    @State private var showEventDetails = false
    @State private var selectedEvent: Event?
    
    // Lista de eventos
    var events: [Event] = [
        Event(title: "Taller de Apoyo Psicológico", date: "25 Noviembre 2024", description: "Charla sobre manejo emocional para víctimas de violencia", location: "Online", registrationLink: "https://www.evento.com"),
        Event(title: "Grupo de Apoyo para Mujeres", date: "30 Noviembre 2024", description: "Espacio de apoyo grupal para mujeres sobrevivientes", location: "Centro de Apoyo, Lima", registrationLink: "https://www.evento.com")
    ]
    
    var body: some View {
        VStack {
            // Título principal para los eventos
            Text("Eventos de Apoyo")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.pink)
                .padding(.top, 40)
            
            Text("Participa en eventos y solicita asesoría de especialistas.")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.horizontal, 20)
            
            // Sección de inscripción a eventos
            VStack {
                Text("Eventos Programados")
                    .font(.headline)
                    .foregroundColor(.pink)
                    .padding(.top, 40)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(events) { event in
                            EventCard(event: event, onSelect: {
                                self.selectedEvent = event
                                showEventDetails.toggle()
                            })
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            // Detalles del evento seleccionado
            if let selectedEvent = selectedEvent, showEventDetails {
                EventDetailsView(event: selectedEvent)
                    .padding(.top, 30)
            }
            
            Spacer()
        }
        .background(Color.pink.opacity(0.1).edgesIgnoringSafeArea(.all))
    }
}

struct Event: Identifiable {
    var id = UUID()
    var title: String
    var date: String
    var description: String
    var location: String
    var registrationLink: String
}

struct EventCard: View {
    var event: Event
    var onSelect: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(event.title)
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Text(event.date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Text(event.description)
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top, 5)
            
            HStack {
                Text("Ubicación: \(event.location)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Button(action: {
                    if let url = URL(string: event.registrationLink) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Inscribirse")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.pink)
                        .cornerRadius(10)
                }
            }
            .padding(.top, 10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct EventDetailsView: View {
    var event: Event
    
    var body: some View {
        VStack {
            Text(event.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.pink)
            
            Text("Fecha: \(event.date)")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 5)
            
            Text(event.description)
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top, 10)
            
            Text("Ubicación: \(event.location)")
                .font(.body)
                .foregroundColor(.black)
                .padding(.top, 5)
            
            Button(action: {
                if let url = URL(string: event.registrationLink) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Inscribirse")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.pink)
                    .cornerRadius(15)
                    .shadow(radius: 10)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.horizontal, 20)
    }
}

struct EventsSupportView_Previews: PreviewProvider {
    static var previews: some View {
        EventoApoyoView()
    }
}
