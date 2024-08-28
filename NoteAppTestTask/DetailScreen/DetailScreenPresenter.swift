import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func editNote()
    func saveNote(updatedNote: NoteStruct)
}

final class DetailPresenter {
    weak var view: DetailViewControllerProtocol?
    private var note: NoteStruct
    private let index: Int
    
    init(note: NoteStruct, index: Int) {
        self.note = note
        self.index = index
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad() {
        view?.displayNoteDetails(note: note)
    }
    
    func editNote() {
        view?.setEditingMode(true)
    }
    
    func saveNote(updatedNote: NoteStruct) {
        note = updatedNote
        view?.setEditingMode(false)
        view?.displayNoteDetails(note: note)
    }
}
