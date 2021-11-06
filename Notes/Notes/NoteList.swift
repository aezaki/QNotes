//
//  NoteList.swift
//  Notes
//
//  Created by Andrew Z on 2021-10-17.
//

import SwiftUI

struct NoteList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
      
      entity: Note.entity(),
      
      sortDescriptors: [
        NSSortDescriptor(keyPath: \Note.title, ascending: true)
      ]
      
    ) var notes: FetchedResults<Note>

    @State var isPresented = false

    var body: some View {
      NavigationView {
        List {
          ForEach(notes, id: \.title) {
              NoteRow(note: $0)
          }
          .onDelete(perform: deleteNote)
        }
        .sheet(isPresented: $isPresented) {
          AddNote { title, note, creation, prioitiy in
            self.addNote(title: title, note: note, creationDate: creation, prioitiy: prioitiy)
            self.isPresented = false
          }
        }
        .navigationBarTitle(Text("My Notes"))
        .navigationBarItems(trailing:
          Button(action: { self.isPresented.toggle() }) {
            Image(systemName: "plus")
          }
        )
      }
    }

    func deleteNote(at offsets: IndexSet) {
      
      offsets.forEach { index in
        
        let note = self.notes[index]

        
        self.managedObjectContext.delete(note)
      }

      
      saveContext()
    }


    func addNote(title: String, note: String, creationDate: Date, prioitiy: Bool) {
      
      let newNote = Note(context: managedObjectContext)

      
      newNote.title = title
      newNote.note = note
      newNote.creationDate = creationDate
      newNote.prioitiy = prioitiy

      
      saveContext()
    }


    func saveContext() {
      do {
        try managedObjectContext.save()
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }
  }

struct NoteList_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
    }
}
