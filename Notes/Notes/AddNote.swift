//
//  AddNote.swift
//  Notes
//
//  Created by Andrew Z on 2021-10-17.
//

import SwiftUI

struct AddNote: View {
    static let DefaultNoteTitle = "Note"
    static let DefaultNote = ""
    
    @State var title = ""
    @State var note = ""
    @State var creationDate = Date()
    @State var prioitiy = false
    @State private var isEditing = false
    let onComplete: (String, String, Date, Bool) -> Void
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Title")) {
                    TextField("Title", text: $title)
                }
                Section(header: Text("Note")) {
                    HStack {
                        TextEditor(text: $note)
                            .onTapGesture {
                                self.isEditing = true
                            }
                        if isEditing {
                            Button(action: {
                                self.isEditing = false
                                hideKeyboard()
                                
                            }) {
                                Text("Done")
                            }
                            .padding(.trailing, 10)
                            .transition(.move(edge: .trailing))
                        }
                    }
                }
                Section {
                  DatePicker(
                    selection: $creationDate,
                    displayedComponents: .date) { Text("Date Created").foregroundColor(Color(.gray)) }
                }
                Section {
                    Toggle("High Priority", isOn: $prioitiy)
                }
                Section{
                    Button(action: addNoteAction) {
                        Text("Add Note")
                    }
                }
                
                
            }
            .navigationBarTitle(Text("Add Note"), displayMode: .inline)
        }
    }
    
    private func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
    
    private func addNoteAction() {
        onComplete(
            title.isEmpty ? AddNote.DefaultNoteTitle : title,
            note.isEmpty ? AddNote.DefaultNote : note,
            creationDate,
            prioitiy
        )
    }
}


