//
//  ContentView.swift
//  reMind
//
//  Created by Pedro Sousa on 23/06/23.
//

import SwiftUI

struct BoxesView: View {
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 140), spacing: 20),
        GridItem(.adaptive(minimum: 140), spacing: 20)
    ]
    
    @ObservedObject var viewModel: BoxViewModel
    @State private var isCreatingNewBox: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.boxes) { box in
                    NavigationLink {
                        BoxView(box: box)
                    } label: {
                        BoxCardView(boxName: box.name ?? "Unkown",
                                    numberOfTerms: box.numberOfTerms,
                                    theme: box.theme)
                        .reBadge(viewModel.getNumberOfPendingTerms(of: box))
                    }
                }
            }
            .padding(40)
        }
        .padding(-20)
        .navigationTitle("Boxes")
        .background(reBackground())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isCreatingNewBox.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isCreatingNewBox) {
            BoxEditorView(name: "",
                          keywords: "",
                          description: "",
                          theme: 0)
        }
    }
}

struct BoxesView_Previews: PreviewProvider {

    static let viewModel: BoxViewModel = {
        let box1 = Box(context: CoreDataStack.inMemory.managedContext)
        box1.name = "Box 1"
        box1.rawTheme = 0

        let term = Term(context: CoreDataStack.inMemory.managedContext)
        term.lastReview = Calendar.current.date(byAdding: .day,
                                                value: -5,
                                                to: Date())!
        box1.addToTerms(term)

        let box2 = Box(context: CoreDataStack.inMemory.managedContext)
        box2.name = "Box 2"
        box2.rawTheme = 1

        let box3 = Box(context: CoreDataStack.inMemory.managedContext)
        box3.name = "Box 3"
        box3.rawTheme = 2

        return BoxViewModel()
    }()
    
    static var previews: some View {
        NavigationStack {
            BoxesView(viewModel: BoxesView_Previews.viewModel)
        }
    }
}
