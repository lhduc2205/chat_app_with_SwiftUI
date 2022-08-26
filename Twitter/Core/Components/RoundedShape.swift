//
//  RoundedShape.swift
//  Twitter
//
//  Created by lhduc on 17/08/2022.
//

import SwiftUI

struct RoundedShape: Shape {
    let corners: UIRectCorner
    let radius: Double
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
