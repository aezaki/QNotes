//
//  NoteRow.swift
//  Notes
//
//  Created by Andrew Z on 2021-10-17.
//

import SwiftUI

import SwiftUI

struct NoteRow: View {
  let note: Note
  static let creationFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
  }()

  var body: some View {
    VStack(alignment: .leading) {
      note.title.map(Text.init)
        .font(note.prioitiy ? .system(size: 50) : .system(size: 40))
        .foregroundColor(note.prioitiy ? .red : .primary)
        
      HStack {
        note.note.map(Text.init)
          .font(.caption)
        Spacer()
        note.creationDate.map { Text(Self.creationFormatter.string(from: $0)) }
          .font(.caption)
      }
    }
    .foregroundColor(note.prioitiy ? .blue : .primary)
  }
        
}
