//
//  SearchBar.swift
//  Twitter
//
//  Created by lhduc on 24/08/2022.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    @State private var leadingIconColor = Color(.gray)
    @State private var isFocus = false
    
    var body: some View {
        TextField(
            "Search",
            text: $text,
            onEditingChanged: { isEditting in
                self.isFocus = isEditting
                self.leadingIconColor = isEditting ? Color(.systemBlue) : Color(.gray)
            }
        )
        .padding(.horizontal, 45)
        .padding(.vertical, 15)
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(self.leadingIconColor)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 15)
                
                if(self.isFocus && !self.text.isEmpty) {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 15)
                    }

                }
                
            }
        )
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
