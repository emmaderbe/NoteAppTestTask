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
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleCoreDataChange), name: .coreDataDidChange, object: nil)
    }
    
    func setupDataSource() {
        dataSource.delegate = self
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
    
    @objc private func handleCoreDataChange() {
        DispatchQueue.main.async {
            self.presenter.reloadNotesFromCoreData()
        }
    }
}

extension MainScreenViewController: NoteCollectionDelegateProtocol {
    func noteSelected(at index: Int) {
        presenter.noteSelected(at: index)
    }
    
    func deleteNoteAt(index: Int) {
        presenter.deleteNoteAt(index: index)
    }
}

extension MainScreenViewController: MainScreenPresenterProtocol {
    func displayNotes() {
        let notes = presenter.notes
        dataSource.updateNotes(notes)
        delegate.updateNotes(notes)
        mainView.reloadData()
    }
    
    func navigateToView(with note: NoteStruct, at index: Int) {
        let detailPresenter = DetailPresenter(note: note, index: index)
        let detailViewController = DetailViewController(presenter: detailPresenter)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

private extension MainScreenViewController {
    func navigateToAddNote() {
        let addNotePresenter = AddNotesScreenPresenter()
        let addNoteVC = AddNotesScreenViewController(presenter: addNotePresenter)
        navigationController?.pushViewController(addNoteVC, animated: true)
    }
}
