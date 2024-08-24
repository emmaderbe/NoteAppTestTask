import UIKit

final class NoteCollectionViewCell: UICollectionViewCell {
    private let noteName = LabelFactory.createTitleLabel()
    private let noteDate = LabelFactory.createOrdinaryLabel()
    private let noteStatus = LabelFactory.createOrdinaryLabel()
    private let noteDescription = LabelFactory.createTitleLabel()
    
    private let backgorundView = ViewFactory.backgroundView(cornerRadius: 16)
    private let vertStack = StackFactory.createVerticalStack(spacing: 4)
    private let horizStack = StackFactory.createHorizontalStack(spacing: 8)
    
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
        backgroundColor = .clear
        
        addSubview(backgorundView)
        backgorundView.addSubview(vertStack)
        
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
            backgorundView.topAnchor.constraint(equalTo: topAnchor),
            backgorundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgorundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgorundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            vertStack.topAnchor.constraint(equalTo: backgorundView.topAnchor, constant: MainScreenEnum.NoteCellConstraints.top),
            vertStack.leadingAnchor.constraint(equalTo: backgorundView.leadingAnchor, constant: MainScreenEnum.NoteCellConstraints.leading),
            vertStack.trailingAnchor.constraint(equalTo: backgorundView.trailingAnchor, constant: MainScreenEnum.NoteCellConstraints.trailing),
            vertStack.bottomAnchor.constraint(equalTo: backgorundView.bottomAnchor, constant: MainScreenEnum.NoteCellConstraints.bottom),
        ])
    }
}

// edit to configure with struct
extension NoteCollectionViewCell {
    func setupText(name: String, date: String, status: String, description: String) {
        noteName.text = name
        noteDate.text = date
        noteStatus.text = status
        noteDescription.text = description
    }
}

extension NoteCollectionViewCell {
    static var identifier: String {
        String(describing: NoteCollectionViewCell.self)
    }
}
