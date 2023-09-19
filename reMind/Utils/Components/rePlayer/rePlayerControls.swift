//
//  rePlayer.swift
//  Playground
//
//  Created by Pedro Sousa on 11/05/23.
//

import SwiftUI

struct rePlayerControls: View {
    @ObservedObject var provider: rePlayerProvider

    var body: some View {
        HStack(spacing: 25) {
            backwardButton
            goBackwardButton
            playPauseButton
            goForwardButton
            forwardButton
        }
    }

    private var playPauseButton: some View {
        reControlButton((provider.state == .pause) ? "play.fill" : "pause.fill") {
            provider.run(.playPause)
        }
        .guard(provider.badges[.playPause]) { (badgeValue, button) in
            button.reBadge(badgeValue)
        }
    }

    private var forwardButton: some View {
        reControlButton("forward.fill") {
            provider.run(.forward)
        }
        .guard(provider.badges[.forward]) { (badgeValue, button) in
            button.reBadge(badgeValue)
        }
    }

    private var backwardButton: some View {
        reControlButton("backward.fill") {
            provider.run(.backward)
        }
        .guard(provider.badges[.backward]) { (badgeValue, button) in
            button.reBadge(badgeValue)
        }
    }

    private var goForwardButton: some View {
        reControlButton("goforward.5") {
            provider.run(.goForward)
        }
        .guard(provider.badges[.goForward]) { (badgeValue, button) in
            button.reBadge(badgeValue)
        }
    }

    private var goBackwardButton: some View {
        reControlButton("gobackward.5"){
            provider.run(.goBackward)
        }
        .guard(provider.badges[.goBackward]) { (badgeValue, button) in
            button.reBadge(badgeValue)
        }
    }
}

extension rePlayerControls {
    enum Controls: String {
        case playPause
        case forward
        case backward
        case goForward
        case goBackward
    }
}

struct rePlayerControls_Previews: PreviewProvider {
    static let provider = {
        var provider = rePlayerProvider(name: "Blinker")

        provider.setAction(to: .playPause) {
            print("playPause")
            print("Action:", provider.state.rawValue)
            provider.toggleState()
        }

        provider.setAction(to: .backward) {
            print("backward speed")
            provider.setBadge(to: .forward, nil)
            provider.setBadge(to: .backward, "2x")
        }

        provider.setAction(to: .forward) {
            print("forward speed")
            provider.setBadge(to: .backward, nil)
            provider.setBadge(to: .forward, "2x")
        }

        provider.setAction(to: .goBackward) {
            print("go backward action")
        }

        provider.setAction(to: .goForward) {
            print("go forward action")
        }

        return provider
    }()

    static var previews: some View {
        rePlayerControls(provider: rePlayer_Previews.provider)
    }
}
