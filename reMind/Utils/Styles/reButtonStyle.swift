//
//  reButtonStyle.swift
//  reMind
//
//  Created by Pedro Sousa on 30/06/23.
//

import SwiftUI

struct reButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body)
            .fontWeight(.bold)
            .foregroundColor(Palette.selectionColor.render)
            .frame(height: 48)
            .background {
                Rectangle()
                    .fill(Color.accentColor)
                    .cornerRadius(10)
            }
    }
}
