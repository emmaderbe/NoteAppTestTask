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
        detailView.setupText(title: "DETAIL INFO",
                             editBttn: "EDIT TASK",
                             saveBttn: "SAVE TASK")
        
        buttonAction()
    }
    
    
    func buttonAction() {
        detailView.onEditTapped = { [weak self] in
            guard let self = self else { return }
        }
        
        detailView.onSaveTapped = { [weak self] updatedNote in
            guard let self = self else { return }
        }
    }
}

extension DetailViewController: DetailPresenterProtocol {
    func displayNoteDetails(note: NoteStruct) {
        detailView.setupData(with: note)
    }
}
