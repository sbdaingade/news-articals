//
//  SDHUDLoader.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 25/03/25.
//
import SwiftUI

struct SDHUDLoader: View {
    
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1.0
    let message: String?
    
    init(message: String? = nil) {
        self.message = message
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()
            VStack {
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(
                        AngularGradient(gradient: Gradient(colors:  [.blue, .red, .purple, .blue]), center: .center),
                        style: StrokeStyle(lineWidth: 3, lineCap: .round)
                    )
                    .frame(width: 45, height: 45)
                    .rotationEffect(.degrees(rotation))
                    .scaleEffect(scale)
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: rotation)
                    .onAppear {
                        self.rotation = 360
                        withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: false)) {
                            scale = 1.0
                        }
                    }

                if let message = message {
                    Text(message)
                        .padding(.top, 15)
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .padding(30)
            .background(Color.black.opacity(0.8))
            .foregroundStyle(.white)
            .cornerRadius(15)
            
        }
        .allowsHitTesting(false)
    }
}

#Preview {
    SDHUDLoader(message: "Loader...")
}
