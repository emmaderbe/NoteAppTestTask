import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    func displayNotes()
    func navigateToView(with note: NoteStruct)
}

final class MainScreenPresenter {
    weak var view: MainScreenPresenterProtocol?
    var notes: [NoteStruct] = []
}

extension MainScreenPresenter {
    func viewDidLoad(view: MainScreenPresenterProtocol) {
        self.view = view
        view.displayNotes()
    }
}

extension MainScreenPresenter {
    func addNote(_ note: NoteStruct) {
        notes.insert(note, at: 0)
        view?.displayNotes()
    }
}

extension MainScreenPresenter {
    func noteSelected(at index: Int) {
        let selectedNote = notes[index]
        view?.navigateToView(with: selectedNote)
    }
}
