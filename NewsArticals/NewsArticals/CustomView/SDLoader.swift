//
//  SDLoader.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 22/02/25.
//

import SwiftUI

enum HUDStatus {
    case loading, success, failure, none
}

struct HUDLoaderView: View {
    var status: HUDStatus
    var message: String
    var onDismiss: (() -> Void)? = nil
    
    @State private var showHUD = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    if status != .loading {
                        onDismiss?()
                    }
                }
            
            VStack(spacing: 15) {
                if status == .loading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                } else {
                    Image(systemName: status == .success ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(status == .success ? .green : .red)
                        .transition(.scale)
                }
                
                Text(message)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding(20)
            .background(Color.black.opacity(0.8))
            .cornerRadius(12)
            .shadow(radius: 10)
            .scaleEffect(showHUD ? 1 : 0.5)
            .opacity(showHUD ? 1 : 0)
            .animation(.spring(), value: showHUD)
        }
        .onAppear {
            showHUD = true
            if status == .success || status == .failure {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    onDismiss?()
                }
            }
        }
        .onDisappear {
            showHUD = false
        }
    }
}

// MARK: - Usage Example
//struct ContentView: View {
//    @State private var hudStatus: HUDStatus = .none
//    @State private var showHUD = false
//    @State private var message = "Loading..."
//
//    var body: some View {
//        ZStack {
//            VStack(spacing: 20) {
//                Button("Show Loader") {
//                    showHUD = true
//                    hudStatus = .loading
//                    message = "Processing..."
//
//                    // Simulating a network request
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                        let success = Bool.random()
//                        hudStatus = success ? .success : .failure
//                        message = success ? "Success!" : "Failed!"
//
//                        // Hide HUD after success/failure
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                            showHUD = false
//                        }
//                    }
//                }
//                .buttonStyle(.borderedProminent)
//            }
//
//            if showHUD {
//                HUDLoaderView(status: hudStatus, message: message) {
//                    showHUD = false
//                }
//            }
//        }
//    }
//}
