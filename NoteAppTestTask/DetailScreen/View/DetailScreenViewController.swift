import UIKit

final class DetailViewController: UIViewController {
    private let detailView = DetailScreenView()
    private var presenter: DetailPresenter
    
    init(presenter: DetailPresenter) {
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
        presenter.viewDidLoad(view: self)
        setupView()
    }
}

private extension DetailViewController {
    func setupView() {
        detailView.setupText(title: DetailScreenEnum.DetailScreenString.title,
                             editBttn: DetailScreenEnum.DetailScreenString.editButton,
                             saveBttn: DetailScreenEnum.DetailScreenString.saveButton)
        editButtonAction()
        saveButtonAction()
    }
    
    func editButtonAction() {
        detailView.onEditTapped = { [weak self] in
            guard let self = self else { return }
            detailView.setEditingMode(true)
        }
    }
}

private extension DetailViewController {
    func saveButtonAction() {
        detailView.onSaveTapped = { [weak self] in
            guard let self = self else { return }
            if let name = detailView.getNoteName(), !name.isEmpty {
                let updatedNote = NoteStruct(
                    name: name,
                    descriptions: detailView.getNoteDescription() ?? "",
                    date: detailView.getDate(),
                    status: detailView.getStatus()
                )
                self.presenter.saveNote(updatedNote: updatedNote)
                self.detailView.setEditingMode(false)
            } else {
                showAlert(message: DetailScreenEnum.DetailScreenString.messageAlert)
                return
            }
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: DetailScreenEnum.DetailScreenString.titleAlert, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension DetailViewController: DetailPresenterProtocol {
    func displayNoteDetails(note: NoteStruct) {
        detailView.setupData(with: note)
    }
}
