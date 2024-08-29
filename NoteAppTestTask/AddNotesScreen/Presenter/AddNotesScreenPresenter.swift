import Foundation

protocol AddNotesScreenPresenterProtocol: AnyObject {
    func noteSavedSuccessfully()
}

final class AddNotesScreenPresenter {
    weak var view: AddNotesScreenPresenterProtocol?
    weak var delegate: AddNotesScreenViewControllerDelegate?
    
    private let noteManager: NoteManagerProtocol
    
    init(noteManager: NoteManagerProtocol = NoteManager()) {
        self.noteManager = noteManager
    }
}

extension AddNotesScreenPresenter {
    func viewDidLoad(view: AddNotesScreenPresenterProtocol) {
        self.view = view
    }
    
    func saveNote(name: String, description: String?) {
        let note = NoteStruct(name: name,
                              descriptions: description ?? "",
                              date: Date(),
                              status: false)
        noteManager.addNote(note)
        delegate?.didAddNote(note)
        view?.noteSavedSuccessfully()
    }
}
