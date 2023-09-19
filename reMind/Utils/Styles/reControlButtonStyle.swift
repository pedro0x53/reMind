//
//  reControlButtonStyle.swift
//  Playground
//
//  Created by Pedro Sousa on 11/05/23.
//

import SwiftUI

struct reControlButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)

            configuration.label
                .foregroundColor(.black)
                .fontWeight(.semibold)
        }
        .shadow(radius: 10)
    }
}
