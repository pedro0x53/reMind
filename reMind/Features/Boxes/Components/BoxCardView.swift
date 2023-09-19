//
//  BoxCardView.swift
//  reMind
//
//  Created by Pedro Sousa on 27/06/23.
//

import SwiftUI

struct BoxCardView: View {
    @State private var boxName: String
    @State private var numberOfTerms: Int
    @State private var theme: reTheme

    init(boxName: String, numberOfTerms: Int, theme: reTheme) {
        self.boxName = boxName
        self.numberOfTerms = numberOfTerms
        self.theme = theme
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(boxName)
                .font(.title3)
                .fontWeight(.bold)
            
            Label("\(numberOfTerms) terms", systemImage: "doc.plaintext.fill")
                .padding(8)
                .background(Palette.reBlack.render.opacity(0.2))
                .cornerRadius(10)
        }
        .foregroundColor(Palette.reBlack.render)
        .padding(16)
        .frame(width: 165, alignment: .leading)
        .background(theme.render)
        .cornerRadius(10)
    }
}

struct BoxCardView_Previews: PreviewProvider {
    static var previews: some View {
        BoxCardView(boxName: "Math",
                    numberOfTerms: 35,
                    theme: .mauve)
    }
}
