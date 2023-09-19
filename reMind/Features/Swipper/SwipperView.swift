//
//  SwipperView.swift
//  reMind
//
//  Created by Pedro Sousa on 03/07/23.
//

import SwiftUI

struct SwipperView: View {
    @State var review: SwipeReview
    @State private var direction: SwipperDirection = .none

    var body: some View {
        VStack {
            SwipperLabel(direction: $direction)
                .padding()

            Spacer()

            SwipperCard(direction: $direction,
                frontContent: {
                    Text("Term")
                }, backContent: {
                    Text("Meaning")
                })

            Spacer()

            Button(action: {
                print("finish review")
            }, label: {
                Text("Finish Review")
                    .frame(maxWidth: .infinity, alignment: .center)
            })
            .buttonStyle(reButtonStyle())
            .padding(.bottom, 30)
                
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(reBackground())
        .navigationTitle("\(review.termsToReview.count) terms left")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SwipperView_Previews: PreviewProvider {
    static let term: Term = {
        let term = Term(context: CoreDataStack.inMemory.managedContext)
        term.value = "Term"
        term.meaning = "Meaning"
        term.rawSRS = 0
        term.rawTheme = 0
        
        return term
    }()
    static var previews: some View {
        NavigationStack {
            SwipperView(review: SwipeReview(termsToReview: [
                Term(context: CoreDataStack.inMemory.managedContext)
            ]))
        }
    }
}
