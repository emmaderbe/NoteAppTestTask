import Foundation
import CoreData

protocol NoteManagerProtocol {
    func loadCoreDataNotes()
    func loadNotes(from notes: [NoteStruct])
    func getNotes() -> [NoteStruct]
    func addNote(_ note: NoteStruct)
    func editNote(_ note: NoteStruct, at index: Int)
    func deleteNoteAt(index: Int)
}

final class NoteManager: NoteManagerProtocol {
    private var notes: [NoteStruct] = []
    private let coreDataManager: CoreDataProtocol
    
    init(coreDataManager: CoreDataProtocol = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
}

extension NoteManager {
    func loadNotes(from notes: [NoteStruct]) {
        self.notes = notes
        notes.forEach { coreDataManager.addNoteEntity(from: $0) }
    }
    
    func loadCoreDataNotes() {
        self.notes = coreDataManager.fetchNotes().map {
            NoteStruct(
                name: $0.name ?? "",
                descriptions: $0.descriptions ?? "",
                date: $0.date ?? Date(),
                status: $0.status
            )
        }
    }
    
    func getNotes() -> [NoteStruct] {
        loadCoreDataNotes()
        return notes
    }
}

extension NoteManager {
    func addNote(_ note: NoteStruct) {
        notes.insert(note, at: 0)
        coreDataManager.addNoteEntity(from: note)
    }
    
    func editNote(_ note: NoteStruct, at index: Int) {
        guard index < notes.count else { return }
        notes[index] = note
        
        let noteEntities = coreDataManager.fetchNotes()
        if index < noteEntities.count {
            coreDataManager.updateNoteEntity(noteEntities[index], with: note)
        }
    }
    
    func deleteNoteAt(index: Int) {
        guard index < notes.count else { return }
        let note = notes.remove(at: index)
        
        let noteEntities = coreDataManager.fetchNotes()
        if let noteEntity = noteEntities.first(where: { $0.name == note.name }) {
            coreDataManager.deleteNoteEntity(noteEntity)
        }
    }
}
