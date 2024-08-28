import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func displayNoteDetails(note: NoteStruct)
    func setEditingMode(_ isEditing: Bool)
}

final class DetailViewController: UIViewController {
    private let detailView = DetailScreenView()
    private var presenter: DetailPresenterProtocol
    
    init(presenter: DetailPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
}

private extension DetailViewController {
    func setupView() {
        detailView.setupText(title: "DETAIL TASK",
                             editBttn: "Edit your task",
                             saveBttn: "Save a task")
        
        buttonAction()
    }
    
    
    func buttonAction() {
        detailView.onEditTapped = { [weak self] in
            guard let self = self else { return }
            self.presenter.editNote()
        }
        
        detailView.onSaveTapped = { [weak self] updatedNote in
            guard let self = self else { return }
            self.presenter.saveNote(updatedNote: updatedNote)
        }
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    func displayNoteDetails(note: NoteStruct) {
        detailView.setup(with: note)
    }
    
    func setEditingMode(_ isEditing: Bool) {
        detailView.setEditingMode(isEditing)
    }
}
