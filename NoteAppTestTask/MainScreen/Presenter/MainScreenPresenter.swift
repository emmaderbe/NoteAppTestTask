import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    func displayNotes()
    func navigateToView(with note: String)
}

final class MainScreenPresenter {
    weak var view: MainScreenPresenterProtocol?
    var notes: [String] = []
}

extension MainScreenPresenter {
    func viewDidLoad(view: MainScreenPresenterProtocol) {
        self.view = view
        view.displayNotes()
    }
}

extension MainScreenPresenter {
    func noteSelected(at index: Int) {
        let selectedNote = notes[index]
        view?.navigateToView(with: selectedNote)
    }
}
