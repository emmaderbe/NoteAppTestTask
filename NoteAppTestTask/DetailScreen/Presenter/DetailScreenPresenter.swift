import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func displayNoteDetails(note: NoteStruct)
}

final class DetailPresenter {
    weak var view: DetailPresenterProtocol?
    private var note: NoteStruct
    private let index: Int
    private let noteManager: NoteManagerProtocol
    
    init(note: NoteStruct, index: Int, noteManager: NoteManagerProtocol = NoteManager()) {
        self.note = note
        self.index = index
        self.noteManager = noteManager
    }
}

extension DetailPresenter {
    func viewDidLoad(view: DetailPresenterProtocol) {
        self.view = view
        view.displayNoteDetails(note: note)
    }
}

extension DetailPresenter {
    func saveNote(updatedNote: NoteStruct) {
        DispatchQueue.global(qos: .background).async {
            self.note = updatedNote
            self.noteManager.editNote(self.note, at: self.index)
            DispatchQueue.main.async {
                self.view?.displayNoteDetails(note: self.note)
            }
        }
    }
}
