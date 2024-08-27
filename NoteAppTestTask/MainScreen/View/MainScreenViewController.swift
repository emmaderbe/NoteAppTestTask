import UIKit

final class MainScreenViewController: UIViewController {
    
    private let mainView = MainScreenView()
    private let dataSource = NoteCollectionDataSource()
    private let delegate = NoteCollectionDelegate()
    private var presenter: MainScreenPresenter
    
    init(presenter: MainScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(view: self)
        setupView()
    }
}

private extension MainScreenViewController {
    func setupView() {
        mainView.setupTitle(with: MainScreenEnum.MainScreenString.title)
        setupDataSource()
        setupDelegate()
        setupActions()
    }
    
    func setupDataSource() {
        mainView.setDataSource(dataSource)
    }
    
    func setupDelegate() {
        delegate.delegate = self
        mainView.setDelegate(delegate)
    }
    
    func setupActions() {
        mainView.onBttnTapped = { [weak self] in
            guard let self = self else { return }
            self.navigateToAddNote()
        }
        
        delegate.delegate = self
    }
}

extension MainScreenViewController: NoteCollectionDelegateProtocol {
    func noteSelected(at index: Int) {
        presenter.noteSelected(at: index)
    }
}

extension MainScreenViewController: MainScreenPresenterProtocol {
    func displayNotes() {
        let notes = presenter.notes
        dataSource.updateNotes(notes)
        delegate.updateNotes(notes)
        mainView.reloadData()
    }
    
    func navigateToView(with note: NoteStruct) {
        print(self)
    }
}

private extension MainScreenViewController {
    func navigateToAddNote() {
        let addNotePresenter = AddNotesScreenPresenter()
        let addNoteVC = AddNotesScreenViewController(presenter: addNotePresenter)
        addNotePresenter.delegate = self
        navigationController?.pushViewController(addNoteVC, animated: true)
    }
}

extension MainScreenViewController: AddNotesScreenViewControllerDelegate {
    func didAddNote(_ note: NoteStruct) {
        presenter.addNote(note)
    }
}
