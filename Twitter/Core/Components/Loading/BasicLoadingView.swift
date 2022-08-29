//
//  BasicLoadingView.swift
//  Twitter
//
//  Created by lhduc on 27/08/2022.
//

import SwiftUI

struct BasicLoadingView: View {
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.3).ignoresSafeArea()
                
            VStack(spacing: 15) {
                Text("LOADING")
                    .font(.headline)
                ProgressView()
                    .scaleEffect(1.3)
            }
            .frame(width: 150, height: 150)
            .background(Color.white)
            .foregroundColor(Color.primary)
            .cornerRadius(20)
        }
    }
}

struct BasicLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        BasicLoadingView()
    }
}
