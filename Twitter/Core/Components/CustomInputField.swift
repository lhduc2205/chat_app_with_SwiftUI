//
//  CustomInputField.swift
//  Twitter
//
//  Created by lhduc on 17/08/2022.
//

import SwiftUI

struct CustomInputField: View {
    let placeholderText: String
    let imageName: String
    var isSecure = false
    
    @Binding var text: String
    @FocusState var isInFocus: Bool
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName: imageName)
                    .foregroundColor(getColor())
                
                if(isSecure) {
                    SecureField(
                        placeholderText,
                        text: $text
                    )
                    .focused($isInFocus)
                } else {
                    TextField(
                        placeholderText,
                        text: $text
                    )
                    .focused($isInFocus)
                }
                
                
                
            }
            .padding(.bottom, 5)
            
            Divider()
                .frame(height: 1)
                .background(getColor())
                .padding(.horizontal, 3)
        }
    }
    
    func getColor() -> Color {
        return isInFocus ? Color(.black) : Color(.gray)
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(
            placeholderText: "Email",
            imageName: "envelope",
            isSecure:  true,
            text: .constant("")
        )
    }
}
