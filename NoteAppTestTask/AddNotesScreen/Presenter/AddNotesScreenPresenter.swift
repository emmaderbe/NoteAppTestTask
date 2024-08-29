import Foundation

protocol AddNotesScreenPresenterProtocol: AnyObject {
    func noteSavedSuccessfully()
}


final class AddNotesScreenPresenter {
    weak var view: AddNotesScreenPresenterProtocol?
    weak var delegate: AddNotesScreenViewControllerDelegate?
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
        view?.noteSavedSuccessfully()
        delegate?.didAddNote(note)
    }
}
