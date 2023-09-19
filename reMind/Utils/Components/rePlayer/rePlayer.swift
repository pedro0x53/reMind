//
//  rePlayer.swift
//  Playground
//
//  Created by Pedro Sousa on 11/05/23.
//

import SwiftUI

struct rePlayer<Content: View>: View {
    @ObservedObject var provider: rePlayerProvider
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        BlankZStack {
            VStack(spacing: 24) {
                if provider.isShareable {
                    buildShareButton()
                }

                Spacer()
                
                rePlayerControls(provider: self.provider)
                
                buildQuitButton()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 60)
            .background(reBackground())
            .opacity(provider.isFocused ? 0 : 1)
            
            content()
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1)) {
                provider.toggleFocus()
            }
        }
    }
    
    private func buildQuitButton() -> some View {
        Button(action: {
            provider.quit?()
        }, label: {
            Text("Quit \(provider.name)")
                .frame(maxWidth: .infinity)
        })
        .buttonStyle(reButtonStyle())
    }
    
    private func buildShareButton() -> some View {
        HStack {
            Spacer()
            reControlButton("square.and.arrow.up") {
                provider.share?()
            }
        }
    }
}


struct rePlayer_Previews: PreviewProvider {
    static let provider = {
        var provider = rePlayerProvider(name: "Blinker")

        provider.isShareable()
        
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
        rePlayer(provider: rePlayer_Previews.provider) {
            Text("Word")
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
    }
}
