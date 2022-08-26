//
//  ImageItem.swift
//  Twitter
//
//  Created by lhduc on 26/08/2022.
//

import SwiftUI

struct ImageItem: Identifiable {
    var id = UUID()
    var imageName: String
    var color: Color
    var onPressed: () -> Void
}
