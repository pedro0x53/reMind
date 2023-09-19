//
//  reColorButtonStyle.swift
//  reMind
//
//  Created by Pedro Sousa on 03/07/23.
//

import SwiftUI

struct reColorButtonStyle: ButtonStyle {
    @State var theme: reTheme

    init(_ theme: reTheme) {
        self.theme = theme
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.body)
            .fontWeight(.bold)
            .foregroundColor(Palette.reBlack.render)
            .frame(height: 48)
            .background {
                Rectangle()
                    .fill(theme.render)
                    .cornerRadius(10)
            }
    }
}
