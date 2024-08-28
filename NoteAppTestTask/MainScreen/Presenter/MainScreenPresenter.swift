import Foundation

protocol MainScreenPresenterProtocol: AnyObject {
    func displayNotes()
    func navigateToView(with note: NoteStruct, at index: Int)
    func editNote(_ note: NoteStruct, at index: Int)
}

final class MainScreenPresenter {
    weak var view: MainScreenPresenterProtocol?
    var notes: [NoteStruct] = [
        NoteStruct(name: "Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил, что он у себя в постели превратился в страшное насекомое. Лежа на.", description: "Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил, что он у себя в постели превратился в страшное насекомое. Лежа на панцирнотвердой спине, он видел, стоило ему приподнять голову, свой коричневый, выпуклый, разделенный дугообразными чешуйками живот, на верх", date: .now, status: .random()),
        NoteStruct(name: "Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил, что он у себя в постели превратился в страшное насекомое. Лежа на.", description: "Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил, что он у себя в постели превратился в страшное насекомое. Лежа на панцирнотвердой спине, он видел, стоило ему приподнять голову, свой коричневый, выпуклый, разделенный дугообразными чешуйками живот, на верх", date: .now, status: .random()),
        NoteStruct(name: "Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил, что он у себя в постели превратился в страшное насекомое. Лежа на.", description: "Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил, что он у себя в постели превратился в страшное насекомое. Лежа на панцирнотвердой спине, он видел, стоило ему приподнять голову, свой коричневый, выпуклый, разделенный дугообразными чешуйками живот, на верх", date: .now, status: .random()),
        NoteStruct(name: "Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил, что он у себя в постели превратился в страшное насекомое. Лежа на.", description: "Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил, что он у себя в постели превратился в страшное насекомое. Лежа на панцирнотвердой спине, он видел, стоило ему приподнять голову, свой коричневый, выпуклый, разделенный дугообразными чешуйками живот, на верх", date: .now, status: .random()),
        NoteStruct(name: "Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил, что он у себя в постели превратился в страшное насекомое. Лежа на.", description: "Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил, что он у себя в постели превратился в страшное насекомое. Лежа на панцирнотвердой спине, он видел, стоило ему приподнять голову, свой коричневый, выпуклый, разделенный дугообразными чешуйками живот, на верх", date: .now, status: .random()),
        NoteStruct(name: "Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил, что он у себя в постели превратился в страшное насекомое. Лежа на.", description: "Проснувшись однажды утром после беспокойного сна, Грегор Замза обнаружил, что он у себя в постели превратился в страшное насекомое. Лежа на панцирнотвердой спине, он видел, стоило ему приподнять голову, свой коричневый, выпуклый, разделенный дугообразными чешуйками живот, на верх", date: .now, status: .random()),
    ]
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
    
    func editNote(_ note: NoteStruct, at index: Int) {
        notes[index] = note
        view?.displayNotes()
    }
    
    func deleteNoteAt(index: Int) {
        notes.remove(at: index)
        view?.displayNotes()
    }
}

extension MainScreenPresenter {
    func noteSelected(at index: Int) {
        let selectedNote = notes[index]
        view?.navigateToView(with: selectedNote, at: index)
    }
}
