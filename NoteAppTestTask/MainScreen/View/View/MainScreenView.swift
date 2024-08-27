import UIKit

final class MainScreenView: UIView {
    private let titleLabel = LabelFactory.createSuperTitleLabel()
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backgorundView = ViewFactory.backgroundView(cornerRadius: 16)
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: NoteCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var onBttnTapped: (() -> Void)?
    
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
        addSubview(addButton)
        addSubview(backgorundView)
        backgorundView.addSubview(collectionView)
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
}

private extension MainScreenView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MainScreenEnum.MainScreenConstraints.leading),
            titleLabel.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
            
            addButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 65),
            addButton.widthAnchor.constraint(equalToConstant: 65),
            
            backgorundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: MainScreenEnum.MainScreenConstraints.spacing),
            backgorundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgorundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgorundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: backgorundView.topAnchor, constant: MainScreenEnum.MainScreenConstraints.top),
            collectionView.leadingAnchor.constraint(equalTo: backgorundView.leadingAnchor, constant: MainScreenEnum.MainScreenConstraints.leading),
            collectionView.trailingAnchor.constraint(equalTo: backgorundView.trailingAnchor, constant: MainScreenEnum.MainScreenConstraints.trailing),
            collectionView.bottomAnchor.constraint(equalTo: backgorundView.bottomAnchor),
        ])
    }
}

private extension MainScreenView {
    @objc func addButtonTapped() {
        onBttnTapped?()
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
