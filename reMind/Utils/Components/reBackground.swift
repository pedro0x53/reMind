//
//  reBackground.swift
//  reMind
//
//  Created by Pedro Sousa on 27/06/23.
//

import SwiftUI

struct reBackground: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Palette.aquamarine.render,
                    Palette.lavender.render,
                    Palette.mauve.render
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)

            Rectangle()
                .fill(Color.clear)
                .background(colorScheme == .light ? .regularMaterial : .thickMaterial)
        }
        .ignoresSafeArea()
    }
}

struct reBackground_Previews: PreviewProvider {
    static var previews: some View {
        reBackground()
    }
}
