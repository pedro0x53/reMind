//
//  BoxEditorView.swift
//  reMind
//
//  Created by Pedro Sousa on 29/06/23.
//

import SwiftUI

struct BoxEditorView: View {
    @State var name: String
    @State var keywords: String
    @State var description: String
    @State var theme: Int

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(title: "Name", text: $name)
                reTextField(title: "Keywords",
                            caption: "Separated by , (comma)",
                            text: $keywords)
                
                reTextEditor(title: "Description",
                             text: $description)

                reRadioButtonGroup(title: "Theme",
                                   currentSelection: $theme)
                Spacer()
            }
            .padding()
            .background(reBackground())
            .navigationTitle("New Box")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        print("Cancel")
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        print("Cancel")
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }
}

struct BoxEditorView_Previews: PreviewProvider {
    static var previews: some View {
        BoxEditorView(name: "",
                      keywords: "",
                      description: "",
                      theme: 0)
    }
}
