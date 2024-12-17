//
//  CargaView.swift
//  CHEM
//
//  Created by DAMII on 30/11/24.
//

import SwiftUI

struct CargaView: View {
    @State private var progress = 0.0
    @State private var isActive = false
    @State private var showMessage = true

    var body: some View {
        NavigationStack {
            ZStack {
                Color.pink.opacity(0.1)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("violencia_image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .padding(.top, 30)
                        .blur(radius: 4)
                    
                    VStack {
                        Text("NO MÁS VIOLENCIA")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.pink)
                            .padding(.top, 30)
                            .multilineTextAlignment(.center)
                        
                        Text("Tu bienestar y seguridad es lo primero")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding(.bottom, 20)
                        
                        // Usar ProgressBar con el binding
                        ProgressBar(value: $progress)
                            .frame(width: 350, height: 20)
                            .padding(.top, 30)
                        
                        if showMessage {
                            Text("Gracias por unirte al cambio.                                     ¡No más violencia!")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding(.top, 20)
                                .multilineTextAlignment(.center)
                        }
                        
                        Spacer()
                    }
                    .onAppear {
                        // Animar la barra de progreso
                        withAnimation(.linear(duration: 3)) {
                            progress = 1.0
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isActive = true
                        }
                    }
                }
            }
            .background(
                NavigationLink(
                    destination: LoginView(),
                    isActive: $isActive,
                    label: { EmptyView() }
                ).hidden()
            )
        }
    }
}

struct ProgressBar: View {
    @Binding var value: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Barra de fondo (gris)
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 20) // Barra más ancha y grande
            
            // Barra de progreso (color rosa)
            Capsule()
                .fill(Color.pink)
                .frame(width: CGFloat(value) * 350, height: 20)
                .animation(.linear(duration: 3), value: value)
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CargaView()
    }
}
