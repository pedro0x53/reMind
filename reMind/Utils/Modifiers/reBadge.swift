//
//  reBadge.swift
//  reMind
//
//  Created by Pedro Sousa on 28/06/23.
//

import SwiftUI

struct reBadgeModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    @State var value: String

    private var textColor: Color {
        colorScheme == .light ? Palette.reWhite.render : Palette.reBlack.render
    }

    private var backgroundColor: Color {
        colorScheme == .light ? Palette.reBlack.render : Palette.reWhite.render
    }

    func body(content: Content) -> some View {
        if value.isEmpty {
            content
        } else {
            content
                .overlay {
                    GeometryReader { reader in
                        Text(value)
                            .padding(6)
                            .font(.body)
                            .foregroundColor(textColor)
                            .fontWeight(.bold)
                            .background {
                                RoundedRectangle(cornerRadius: 17.5)
                                    .fill(backgroundColor)
                                    .frame(height: 35)
                                    .frame(minWidth: 35, maxWidth: 40)
                            }
                            .position(x: reader.size.width - 4, y: 4)
                            .zIndex(.infinity)
                    }
                }
        }
    }
}

extension View {
    func reBadge(_ value: String) -> some View {
        modifier(reBadgeModifier(value: value))
    }
}
