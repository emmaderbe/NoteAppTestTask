import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    func displayNotes()
    func navigateToView(with note: NoteStruct, at index: Int)
    func editNote(_ note: NoteStruct, at index: Int)
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
                print("First launch detected, loading todos from network")
                loadTodosFromNetwork()
            } else {
                print("Not first launch, loading todos from manager")
                loadTodosFromManager()
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
                    self.view?.displayNotes()
                case .failure(let error):
                    print("Failed to load todos: \(error)")
                }
            }
        }
    
    func loadTodosFromManager() {
        DispatchQueue.global(qos: .background).async {
            self.notes = self.noteManager.getNotes()
            DispatchQueue.main.async {
                self.view?.displayNotes()
            }
        }
    }
}

extension MainScreenPresenter {
    func addNote(_ note: NoteStruct) {
        DispatchQueue.global(qos: .background).async {
            self.noteManager.addNote(note)
            DispatchQueue.main.async {
                self.notes.insert(note, at: 0)
                self.view?.displayNotes()
            }
        }
    }
    
    func editNote(_ note: NoteStruct, at index: Int) {
        DispatchQueue.global(qos: .background).async {
            self.noteManager.editNote(note, at: index)
            DispatchQueue.main.async {
                self.notes[index] = note
                self.view?.displayNotes()
            }
        }
    }
    
    func deleteNoteAt(index: Int) {
        DispatchQueue.global(qos: .background).async {
            self.noteManager.deleteNoteAt(index: index)
            DispatchQueue.main.async {
                self.notes.remove(at: index)
                self.view?.displayNotes()
            }
        }
    }
}

extension MainScreenPresenter {
    func noteSelected(at index: Int) {
        let selectedNote = notes[index]
        view?.navigateToView(with: selectedNote, at: index)
    }
}
