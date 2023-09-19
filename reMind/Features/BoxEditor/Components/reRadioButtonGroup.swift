//
//  reRadioButtonGroup.swift
//  reMind
//
//  Created by Pedro Sousa on 30/06/23.
//

import SwiftUI

struct reRadioButtonGroup: View {
    @State var title: String = ""
    @Binding var currentSelection: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if !title.isEmpty {
                Text(title)
                    .font(.body)
                    .fontWeight(.bold)
            }

            HStack(spacing: 20) {
                reRadioButton(tag: 0,
                              currentSelection: $currentSelection,
                              color: Palette.mauve.render)
                reRadioButton(tag: 1,
                              currentSelection: $currentSelection,
                              color: Palette.lavender.render)
                reRadioButton(tag: 2,
                              currentSelection: $currentSelection,
                              color: Palette.aquamarine.render)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct reRadioButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        reRadioButtonGroup(title: "Theme", currentSelection: .constant(0))
    }
}
