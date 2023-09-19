//
//  rePlayerProvider.swift
//  Playground
//
//  Created by Pedro Sousa on 30/05/23.
//

import SwiftUI

class rePlayerProvider: ObservableObject {
    let name: String

    var quit: (() -> Void)?
    var share: (() -> Void)?

    init(name: String) {
        self.name = name
    }

    @Published private(set) var state: rePlayerState = .play
    @Published private(set) var direction: rePlayerDirection = .forward
    @Published private(set) var isShareable: Bool = false
    @Published private(set) var isFocused: Bool = false
    
    @Published private(set) var badges: [rePlayerControls.Controls: String] = [:]
    
    private var actions: [rePlayerControls.Controls: () -> Void] = [:]
    
    func setBadge(to control: rePlayerControls.Controls, _ value: String? = nil) {
        if let newValue = value {
            guard badges[control] != newValue else { return }
            badges[control] = newValue
        } else {
            badges[control] = nil
        }
    }
    
    func setAction(to control: rePlayerControls.Controls, _ action: (() -> Void)?) {
        actions[control] = action
    }
    
    func run(_ control: rePlayerControls.Controls) {
        actions[control]?()
    }
    
    func toggleState() {
        state = (state == .play) ? .pause : .play
    }
    
    func toggleDirection() {
        direction = (direction == .forward) ? .backward : .forward
    }

    func toggleFocus() {
        isFocused.toggle()
    }

    func isShareable(_ value: Bool = true) {
        self.isShareable = value
    }
}
