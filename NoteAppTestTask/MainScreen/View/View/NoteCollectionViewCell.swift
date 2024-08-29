import UIKit

final class NoteCollectionViewCell: UICollectionViewCell {
    private let noteName = LabelFactory.createTitleLabel()
    private let noteDate = LabelFactory.createSubOrdinaryLabel()
    private let noteStatus = LabelFactory.createSubOrdinaryLabel()
    private let noteDescription = LabelFactory.createOrdinaryLabel()
    
    private let flagImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "flag.fill")
        imageView.tintColor = .systemGray
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    private let vertStack = StackFactory.createVerticalStack(spacing: 4)
    private let firstHorizStack = StackFactory.createHorizontalStack(spacing: 16)
    private let secondHorizStack = StackFactory.createHorizontalStack(spacing: 2)
    
    var onDeleteTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContextMenuInteraction()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NoteCollectionViewCell {
    func setupView() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 16
        
        addSubview(vertStack)
        
        vertStack.addArrangedSubview(noteName)
        vertStack.addArrangedSubview(firstHorizStack)
        vertStack.addArrangedSubview(noteDescription)
        
        firstHorizStack.addArrangedSubview(noteDate)
        firstHorizStack.addArrangedSubview(secondHorizStack)
        
        secondHorizStack.addArrangedSubview(flagImageView)
        secondHorizStack.addArrangedSubview(noteStatus)
    }
    
    func setupContextMenuInteraction() {
        let interaction = UIContextMenuInteraction(delegate: self)
        self.addInteraction(interaction)
    }
}

private extension NoteCollectionViewCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            vertStack.topAnchor.constraint(equalTo: topAnchor, constant: MainScreenEnum.NoteCellConstraints.top),
            vertStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MainScreenEnum.NoteCellConstraints.leading),
            vertStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: MainScreenEnum.NoteCellConstraints.trailing),
            vertStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: MainScreenEnum.NoteCellConstraints.bottom),
        
            flagImageView.widthAnchor.constraint(equalToConstant: MainScreenEnum.NoteCellConstraints.imageSize),
            flagImageView.heightAnchor.constraint(equalToConstant: MainScreenEnum.NoteCellConstraints.imageSize)
        ])
    }
}

extension NoteCollectionViewCell {
    func setupText(with data: NoteStruct) {
        noteName.text = data.name
        noteDate.text = data.formattedDate()
        noteStatus.text = data.status ? MainScreenEnum.MainScreenString.completedStatus : MainScreenEnum.MainScreenString.notCompletedStatud
        noteDescription.text = data.description
    }
}

extension NoteCollectionViewCell: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            return self.createContextMenu()
        }
    }

    private func createContextMenu() -> UIMenu {
        let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { [weak self] action in
            guard let self = self else { return }
            self.onDeleteTapped?()
        }
        return UIMenu(title: "", children: [deleteAction])
    }
}

extension NoteCollectionViewCell {
    static var identifier: String {
        String(describing: NoteCollectionViewCell.self)
    }
}
