import Foundation

protocol DetailPresenterProtocol: AnyObject {
    func displayNoteDetails(note: NoteStruct)
}

final class DetailPresenter {
    weak var view: DetailPresenterProtocol?
    private var note: NoteStruct
    private let index: Int
    
    init(note: NoteStruct, index: Int) {
        self.note = note
        self.index = index
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
        note = updatedNote
        view?.displayNoteDetails(note: note)
    }
}
