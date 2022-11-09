//
//  DefaultButton.swift
//  Calculator
//
//  Created by Ondřej Toman on 09.11.2022.
//

import SwiftUI


/// Default gray button for the Calculator keyboard
struct DefaultButton: View {
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    private let portraitHeight: CGFloat = 77
    private let landscapeHeight: CGFloat = 32
    
    let text: String?
    let image: String?
    let buttonAction: () -> Void
    
    init(text: String? = nil, image: String? = nil, buttonAction: @escaping () -> Void) {
        self.text = text
        self.image = image
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        Button {
            buttonAction()
        } label: {
            if image != nil {
                Image(systemName: image!)
            }
            
            if text != nil {
                Text(text!)
            }
        }
        .isDefaultCalculatorButton(btnHeight: verticalSizeClass == .compact ? landscapeHeight : portraitHeight)
    }
}

struct DefaultButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            DefaultButton(text: "9") {
                // Do something...
            }
            
            DefaultButton(image: "apple.logo") {
                // Do something...
            }
        }
        .frame(width: 180, alignment: .center)
    }
}
