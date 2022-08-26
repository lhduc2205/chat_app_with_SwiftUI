//
//  DialogExtension.swift
//  Twitter
//
//  Created by lhduc on 26/08/2022.
//

import Foundation
import SwiftUI

extension View {
    func customDialog<DialogContent: View>(isShowing: Binding<Bool>) -> some View {
        self.modifier(CustomDialog(isShowing: isShowing))
    }
}

