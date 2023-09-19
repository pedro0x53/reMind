//
//  Conditional.swift
//  Playground
//
//  Created by Pedro Sousa on 12/05/23.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition { transform(self) }
        else { self }
    }

    @ViewBuilder func `guard`<Content: View, T>(_ optional: T?, transform: (T, Self) -> Content) -> some View {
        if let value = optional { transform(value, self) }
        else { self }
    }
}
