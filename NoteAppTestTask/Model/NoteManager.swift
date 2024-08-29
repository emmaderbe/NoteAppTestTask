import Foundation

protocol NoteManagerProtocol {
    func loadNotes(from notes: [NoteStruct])
    func getNotes() -> [NoteStruct]
    func addNote(_ note: NoteStruct)
    func editNote(_ note: NoteStruct, at index: Int)
    func deleteNoteAt(index: Int)
}

final class NoteManager: NoteManagerProtocol {
    private var notes: [NoteStruct] = []
    
    func loadNotes(from notes: [NoteStruct]) {
            self.notes = notes
    }
    
    func getNotes() -> [NoteStruct] {
        return notes
    }
    
    func addNote(_ note: NoteStruct) {
        notes.insert(note, at: 0)
    }
    
    func editNote(_ note: NoteStruct, at index: Int) {
        guard index < notes.count else { return }
        notes[index] = note
    }
    
    func deleteNoteAt(index: Int) {
        guard index < notes.count else { return }
        notes.remove(at: index)
    }
}
