//
//  reTexFieldStyle.swift
//  reMind
//
//  Created by Pedro Sousa on 29/06/23.
//

import SwiftUI

struct reTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(height: 42)
            .padding(.horizontal, 8)
            .background(Palette.background.render)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.25) ,radius: 10)
    }
}
