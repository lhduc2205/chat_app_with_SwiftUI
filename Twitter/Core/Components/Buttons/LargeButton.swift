//
//  LargeButton.swift
//  Twitter
//
//  Created by lhduc on 17/08/2022.
//

import SwiftUI

struct LargeButton: View {
    let label:                  String
    var leadingSystemImage:     String?
    var trailingSystemImage:    String?
    var radius:                 Double  = 30.0
    var minHeight:              Double  = 30.0
    var spacing:                Double  = 5
    var isDisabled:             Bool    = false
    var primaryColor:           Color   = Color(.systemBlue)
    let onPressed:              () -> ()
    
    var body: some View {
        Button {
            onPressed()
        } label: {
            HStack(spacing: spacing) {
                if let leadingSystemImage = leadingSystemImage {
                    Image(systemName: leadingSystemImage)
                }
                
                Text(label)
                    .fontWeight(.semibold)
                
                if let trailingSystemImage = trailingSystemImage {
                    Image(systemName: trailingSystemImage)
                }
                
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: minHeight)
            .background(isDisabled ? primaryColor.opacity(0.5) : primaryColor)
            .foregroundColor(.white)
            .cornerRadius(radius)
        }
        .disabled(isDisabled)
        
    }
}
