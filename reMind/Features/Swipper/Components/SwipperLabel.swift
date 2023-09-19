//
//  SwipperLabel.swift
//  reMind
//
//  Created by Pedro Sousa on 03/07/23.
//

import SwiftUI

enum SwipperDirection: String {
    case left
    case right
    case none
}

struct SwipperLabel: View {
    @Binding var direction: SwipperDirection

    private var text: String  {
        if direction == .left {
            return "I am still learning this term..."
        }

        if direction == .right {
            return "I remember this term!"
        }

        return ""
    }
    
    var body: some View {
        Text(text)
            .fontWeight(.bold)
    }
}

struct SwipperLabel_Previews: PreviewProvider {
    static var previews: some View {
        SwipperLabel(direction: .constant(.right))
    }
}
