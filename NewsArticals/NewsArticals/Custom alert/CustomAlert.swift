//
//  CustomAlert.swift
//  NewsArticals
//
//  Created by Sachin Daingade on 28/11/24.
//

import SwiftUI

/// Alert type
enum AlertType {
    
    case success
    case error(title: String, message: String = "")
    
    func title() -> String {
        switch self {
        case .success:
            return "Success"
        case .error(title: let title, _):
            return title
        }
    }

    func message() -> String {
        switch self {
        case .success:
            return "Please confirm that you're still open to session requests"
        case .error(_, message: let message):
            return message
        }
    }
    
    /// Left button action text for the alert view
    var leftActionText: String {
        switch self {
        case .success:
            return "Ok"
        case .error(_, _):
            return "Ok"
        }
    }
    
    /// Right button action text for the alert view
    var rightActionText: String {
        switch self {
        case .success:
            return "Cancel"
        case .error(_, _):
            return "Cancel"
        }
    }
    
    func height(isShowVerticalButtons: Bool = false) -> CGFloat {
        switch self {
        case .success:
            return isShowVerticalButtons ? 220 : 150
        case .error(_, _):
            return isShowVerticalButtons ? 220 : 150
        }
    }
}

struct CustomAlert: View {
    
    /// Flag used to dismiss the alert on the presenting view
    @Binding var presentAlert: Bool
    
    /// The alert type being shown
    @State var alertType: AlertType = .success
    
    /// based on this value alert buttons will show vertically
    var isShowVerticalButtons = false
    
    var leftButtonAction: (() -> ())?
    var rightButtonAction: (() -> ())?
    
    let verticalButtonsHeight: CGFloat = 80
    
    var body: some View {
        
        ZStack {
            
            // faded background
            Color.black.opacity(0.65)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 0) {
                
                if alertType.title() != "" {
                    
                    // alert title
                    Text(alertType.title())
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(height: 25)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 16)
                }
                
                // alert message
                Text(alertType.message())
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .minimumScaleFactor(0.5)
                
                Divider()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 0.5)
                    .padding(.all, 0)
                
                
                HStack{
                    
                    if !isShowVerticalButtons {
                        HStack(spacing: 0) {
                            
                            // left button
                            if (!alertType.leftActionText.isEmpty) {
                                Button {
                                    leftButtonAction?()
                                } label: {
                                    Text(alertType.leftActionText)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                }
                                Divider()
                                    .frame(minWidth: 0, maxWidth: 0.5, minHeight: 0, maxHeight: .infinity)
                            }
                            
                            // right button (default)
                            Button {
                                rightButtonAction?()
                            } label: {
                                Text(alertType.rightActionText)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(15)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            }
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 55)
                        .padding([.horizontal, .bottom], 0)
                        
                    } else {
                        VStack(spacing: 0) {
                            Spacer()
                            Button {
                                leftButtonAction?()
                            } label: {
                                Text(alertType.leftActionText)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            }
                            Spacer()
                            
                            Divider()
                            
                            Spacer()
                            Button {
                                rightButtonAction?()
                            } label: {
                                Text(alertType.rightActionText)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.pink)
                                    .multilineTextAlignment(.center)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            }
                            Spacer()
                            
                        }
                        .frame(height: verticalButtonsHeight)
                    }
                }
                
            } // Vstack
            .frame(width: 270, height: alertType.height(isShowVerticalButtons: isShowVerticalButtons))
            .background(
                Color(.blue)
            )
            .cornerRadius(4)
        }
    }
}
#Preview {
    CustomAlert(presentAlert: .constant(true), alertType: .error(title: "Alert", message: "New alert message"), isShowVerticalButtons: false) {
        
    } rightButtonAction: {
        
    }
}
