//
//  reControlButton.swift
//  Playground
//
//  Created by Pedro Sousa on 11/05/23.
//

import SwiftUI

struct reControlButton: View {
    private let systemImage: String
    private let action: () -> Void

    init(_ systemImage: String, action: @escaping () -> Void) {
        self.systemImage = systemImage
        self.action = action
    }

    var body: some View {
        Button(action: self.action) {
            Image(systemName: self.systemImage)
                .resizable()
                .scaledToFit()
                .scaleEffect(0.5)
        }
        .buttonStyle(reControlButtonStyle())
        .frame(maxWidth: 50, maxHeight: 50)
    }
}

struct reControlButton_Previews: PreviewProvider {
    static var previews: some View {
        reControlButton("play.fill") {
            print("Action")
        }
    }
}
