import SwiftUI

struct ResourcesView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Título de la pantalla
                Text("Recursos y Apoyo")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.pink)
                    .padding(.top, 20)
                    .padding(.bottom, 10)

                ScrollView {
                    VStack(spacing: 20) {
                        // Recurso de emergencia (Policía)
                        ResourceCard(
                            title: "Policía Nacional del Perú",
                            description: "Llama a la Policía para situaciones de emergencia.",
                            number: "105",
                            icon: "shield.fill",
                            color: Color.red
                        )

                        // Recurso de emergencia (Línea contra violencia familiar)
                        ResourceCard(
                            title: "Línea contra la Violencia Familiar",
                            description: "Asistencia para mujeres víctimas de violencia familiar.",
                            number: "100",
                            icon: "phone.fill",
                            color: Color.blue
                        )

                        // Recurso de emergencia (Línea de emergencia para niños y adolescentes)
                        ResourceCard(
                            title: "Emergencia para Niños y Adolescentes",
                            description: "Asistencia inmediata para niños y adolescentes en situación de abuso.",
                            number: "0800-76263",
                            icon: "house.fill",
                            color: Color.green
                        )

                        // Recurso de apoyo psicológico (Línea de ayuda)
                        ResourceCard(
                            title: "Línea de Ayuda Psicológica",
                            description: "Asesoría psicológica gratuita y confidencial.",
                            number: "1-800-273-TALK",
                            icon: "heart.fill",
                            color: Color.purple
                        )

                        // Recurso de defensa de los derechos humanos (Defensoría del Pueblo)
                        ResourceCard(
                            title: "Defensoría del Pueblo",
                            description: "Línea de apoyo y orientación legal gratuita.",
                            number: "0800-15170",
                            icon: "shield.lefthalf.fill",
                            color: Color.orange
                        )

                        // Recurso de apoyo ONG: Flora Tristán
                        ResourceCard(
                            title: "Casa de la Mujer Flora Tristán",
                            description: "Apoyo legal, psicológico y refugio para mujeres víctimas de violencia.",
                            number: "01 424 8266",
                            icon: "person.2.fill",
                            color: Color.blue
                        )

                        // Recurso para hombres víctimas de violencia
                        ResourceCard(
                            title: "Línea de Apoyo para Hombres Víctimas de Violencia",
                            description: "Línea de ayuda para hombres que sufren violencia.",
                            number: "1800-840",
                            icon: "person.fill",
                            color: Color.yellow
                        )

                        // Recurso de asistencia médica general
                        ResourceCard(
                            title: "Hospitales y Centros de Salud",
                            description: "Llamada para emergencias médicas y asistencia en salud.",
                            number: "105 (Policía también puede dirigir a hospitales)",
                            icon: "stethoscope",
                            color: Color.green
                        )
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 20) // Padding horizontal para no pegarse a los costados
                }

                Spacer()
            }
            .padding(.bottom, 20)
            .background(Color.pink.opacity(0.1).edgesIgnoringSafeArea(.all))
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

struct ResourceCard: View {
    var title: String
    var description: String
    var number: String
    var icon: String
    var color: Color

    var body: some View {
        HStack {
            // Icono del recurso
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
                .padding(10)
                .background(color)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                HStack {
                    Text("Llamar: \(number)")
                        .font(.subheadline)
                        .foregroundColor(color)
                    Spacer()
                    NavigationLink(destination: CallView(name: title, number: number, color: color)) {
                        Image(systemName: "phone.fill")
                            .foregroundColor(color)
                            .padding(5)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                }
            }
            .padding(.leading, 10)

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct CallView: View {
    var name: String
    var number: String
    var color: Color

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Spacer()

            // Información de la llamada
            Text(name)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Text(number)
                .font(.title)
                .foregroundColor(.white)
                .padding(.bottom, 20)

            // Simulando la llamada con más iconos
            HStack {
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(.white)
                Text("Conectando...")
                    .font(.headline)
                    .foregroundColor(.white)
                    .opacity(0.8)
            }
            .padding(.bottom, 30)

            // Botón de colgar
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "phone.down.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.red)
                    .clipShape(Circle())
            }
            .padding(.bottom, 30)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [color, color.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
        )
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct ResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        ResourcesView()
    }
}

