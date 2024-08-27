import UIKit

protocol AddNotesScreenViewControllerDelegate: AnyObject {
    func didAddNote(_ note: NoteStruct)
}

final class AddNotesScreenViewController: UIViewController {
    private let addNotesView = AddNotesScreenView()
    private var presenter: AddNotesScreenPresenter
    
    weak var delegate: AddNotesScreenViewControllerDelegate?
    
    init(presenter: AddNotesScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = addNotesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
        
    }
}

private extension AddNotesScreenViewController {
    func setupView() {
        addNotesView.setupText(title: AddNotesScreenEnum.AddNotesString.title,
                               noteName: AddNotesScreenEnum.AddNotesString.noteName,
                               noteNamePlaceHolder: AddNotesScreenEnum.AddNotesString.noteNamePlaceHolder,
                               noteDescription: AddNotesScreenEnum.AddNotesString.noteDescription,
                               buttonTitle: AddNotesScreenEnum.AddNotesString.buttonTitle)
    }
    
    func setupActions() {
        addNotesView.onBttnTapped = { [weak self] in
            guard let self = self else { return }
            self.saveNote()
        }
    }
}

private extension AddNotesScreenViewController {
    func saveNote() {
        guard let name = addNotesView.getNoteName(), !name.isEmpty else {
            showAlert(message: AddNotesScreenEnum.AddNotesString.messageAlert)
            return
        }
        
        let description = addNotesView.getNoteDescription()
        presenter.saveNote(name: name, description: description)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: AddNotesScreenEnum.AddNotesString.titleAlert, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
