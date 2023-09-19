//
//  BlankZStack.swift
//  Playground
//
//  Created by Pedro Sousa on 16/05/23.
//

import SwiftUI

struct BlankZStack<Content: View>: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
            content()
        }
    }
}

struct BlankZStack_Previews: PreviewProvider {
    static var previews: some View {
        BlankZStack {
            Text("Blank")
        }
    }
}
