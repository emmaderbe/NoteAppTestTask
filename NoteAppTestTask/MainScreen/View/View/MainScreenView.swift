import UIKit

final class MainScreenView: UIView {
    private let titleLabel = LabelFactory.createSuperTitleLabel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: NoteCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
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

private extension MainScreenView {
    func setupView() {
        backgroundColor = .systemBlue
        
        addSubview(titleLabel)
        addSubview(collectionView)
    }
}

private extension MainScreenView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MainScreenEnum.MainScreenConstraints.leading),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: MainScreenEnum.MainScreenConstraints.top),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MainScreenEnum.MainScreenConstraints.leading),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: MainScreenEnum.MainScreenConstraints.trailing),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension MainScreenView {
    func setupTitle(with title: String) {
        titleLabel.text = title
    }
}

extension MainScreenView {
    func setDataSource(_ dataSource: NoteCollectionDataSource) {
        collectionView.dataSource = dataSource
    }
    
    func setDelegate(_ delegate: NoteCollectionDelegate) {
        collectionView.delegate = delegate
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
