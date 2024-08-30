import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    func displayNotes()
    func navigateToView(with note: NoteStruct, at index: Int)
}

final class MainScreenPresenter {
    weak var view: MainScreenPresenterProtocol?
    private let noteManager: NoteManagerProtocol
    private let networkService: NetworkServiceProtocol
    private let isFirstLaunchKey = "isFirstLaunch"
    
    var notes: [NoteStruct] = []
    
    init(noteManager: NoteManagerProtocol = NoteManager(), networkService: NetworkServiceProtocol = NetworkService()) {
        self.noteManager = noteManager
        self.networkService = networkService
    }
}

extension MainScreenPresenter {
    func viewDidLoad(view: MainScreenPresenterProtocol) {
        self.view = view
        
        if isFirstLaunch() {
            loadTodosFromNetwork()
        } else {
            loadTodosFromCoreData()
        }
    }
}

private extension MainScreenPresenter {
    func isFirstLaunch() -> Bool {
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: isFirstLaunchKey)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: isFirstLaunchKey)
        }
        return isFirstLaunch
    }
    
    func loadTodosFromNetwork() {
        networkService.fetchTodos { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let notes):
                self.noteManager.loadNotes(from: notes)
                self.notes = notes
                DispatchQueue.main.async {
                    self.view?.displayNotes()
                }
            case .failure(let error):
                print("Failed to load todos: \(error)")
            }
        }
    }
    
    func loadTodosFromCoreData() {
        DispatchQueue.global(qos: .background).async {
            self.notes = self.noteManager.getNotes()
            DispatchQueue.main.async {
                self.view?.displayNotes()
            }
        }
    }
}

extension MainScreenPresenter {
    func reloadNotesFromCoreData() {
        self.notes = noteManager.getNotes()
        DispatchQueue.main.async {
            self.view?.displayNotes()
        }
    }
}

extension MainScreenPresenter {
    func deleteNoteAt(index: Int) {
        DispatchQueue.global(qos: .background).async {
            self.notes.remove(at: index)
            self.noteManager.deleteNoteAt(index: index)
        }
    }
}

extension MainScreenPresenter {
    func noteSelected(at index: Int) {
        let selectedNote = notes[index]
        view?.navigateToView(with: selectedNote, at: index)
    }
}
