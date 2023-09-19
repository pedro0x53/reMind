//
//  reRadioButton.swift
//  reMind
//
//  Created by Pedro Sousa on 30/06/23.
//

import SwiftUI

struct reRadioButton: View {
    let tag: Int
    @Binding var currentSelection: Int

    let color: Color

    var body: some View {
        ZStack {
            Circle()
                .fill(self.color)

            if currentSelection == tag {
                Circle()
                    .fill(Palette.selectionColor.render)
                    .frame(maxWidth: 30)
            }
        }
        .frame(maxWidth: 50)
        .onTapGesture {
            if currentSelection != tag {
                currentSelection = tag
            }
        }
    }
}

struct reRadioButton_Previews: PreviewProvider {
    static var previews: some View {
        reRadioButton(tag: 0,
                      currentSelection: .constant(0),
                      color: reTheme.mauve.render)
    }
}
