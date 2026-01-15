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
    @Binding var loaderModel: LoaderModel?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
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

                if let img = loaderModel?.icon {
                    Image(img)
                        .font(.system(size: 36))
                        .padding(.top, 10)
                }
                
                if let message = loaderModel?.title {
                    Text(message)
                        .padding(.top, 15)
                        .font(.headline)
                        .foregroundColor(.white)
                }
                
                if let subTitle = loaderModel?.subTitle {
                    Text(subTitle)
                        .padding(.top, 15)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                
            }
            .padding(30)
            .background(Color.black.opacity(0.8))
            .foregroundStyle(.white)
            .cornerRadius(15)
            
        }
    }
}

#Preview {
    @Previewable @State var model: LoaderModel? = LoaderModel()
    return SDHUDLoader(loaderModel: $model)
}
