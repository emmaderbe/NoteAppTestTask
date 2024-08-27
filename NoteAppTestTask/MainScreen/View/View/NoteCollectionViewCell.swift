import UIKit

final class NoteCollectionViewCell: UICollectionViewCell {
    private let noteName = LabelFactory.createTitleLabel()
    private let noteDate = LabelFactory.createSubOrdinaryLabel()
    private let noteStatus = LabelFactory.createSubOrdinaryLabel()
    private let noteDescription = LabelFactory.createOrdinaryLabel()
    
    private let vertStack = StackFactory.createVerticalStack(spacing: 4)
    private let horizStack = StackFactory.createHorizontalStack(spacing: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
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
        vertStack.addArrangedSubview(horizStack)
        vertStack.addArrangedSubview(noteDescription)
        
        horizStack.addArrangedSubview(noteDate)
        horizStack.addArrangedSubview(noteStatus)
    }
}

private extension NoteCollectionViewCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            vertStack.topAnchor.constraint(equalTo: topAnchor, constant: MainScreenEnum.NoteCellConstraints.top),
            vertStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MainScreenEnum.NoteCellConstraints.leading),
            vertStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: MainScreenEnum.NoteCellConstraints.trailing),
            vertStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: MainScreenEnum.NoteCellConstraints.bottom),
        ])
    }
}

extension NoteCollectionViewCell {
    func setupText(with data: NoteStruct) {
        noteName.text = data.name
        noteDate.text = data.date.formatted()
        noteStatus.text = String(data.status)
        noteDescription.text = data.description
    }
}

extension NoteCollectionViewCell {
    static var identifier: String {
        String(describing: NoteCollectionViewCell.self)
    }
}
