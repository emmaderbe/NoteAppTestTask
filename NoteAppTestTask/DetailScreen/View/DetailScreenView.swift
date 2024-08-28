import UIKit

final class DetailScreenView: UIView {
    private let titleLabel = LabelFactory.createSuperTitleLabel()
    private let backgroundView = ViewFactory.backgroundView(cornerRadius: 16)
    
    private let nameLabel = LabelFactory.createDetailTitleLabel()
    private let descriptionLabel = LabelFactory.createOrdinaryLabel()
    private let firstDateLabel = LabelFactory.createSubOrdinaryLabel()
    private let statusLabel = LabelFactory.createSubOrdinaryLabel()
    private let firstVertStack = StackFactory.createVerticalStack(spacing: 8)
    private let secondDateLabel = LabelFactory.createSubOrdinaryLabel()
    private let nameTextField = TextFieldFactory.createTextField(placeholder: "")
    private let descriptionTextView = TextViewFactory.createTextView()
    
    private let statusSegmentControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.insertSegment(withTitle: "Not Completed", at: 0, animated: false)
        segment.insertSegment(withTitle: "Completed", at: 1, animated: false)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    private let secondVertStack = StackFactory.createVerticalStack(spacing: 8)
    
    private let editButton = ButtonFactory.createBlueButton(title: "")
    private let saveButton = ButtonFactory.createBlueButton(title: "")
    
    var onEditTapped: (() -> Void)?
    var onSaveTapped: ((NoteStruct) -> Void)?
    private var firstVertStackConstraints: [NSLayoutConstraint] = []
    private var secondVertStackConstraints: [NSLayoutConstraint] = []
    
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

private extension DetailScreenView {
    func setupView() {
        backgroundColor = .systemBlue
        addSubviews()
        hideView()
        addTargetToBttn()
    }
    
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(backgroundView)
        
        backgroundView.addSubview(firstVertStack)
        firstVertStack.addArrangedSubview(nameLabel)
        firstVertStack.addArrangedSubview(descriptionLabel)
        firstVertStack.addArrangedSubview(firstDateLabel)
        firstVertStack.addArrangedSubview(statusLabel)
        
        backgroundView.addSubview(secondVertStack)
        secondVertStack.addArrangedSubview(nameTextField)
        secondVertStack.addArrangedSubview(descriptionTextView)
        secondVertStack.addArrangedSubview(secondDateLabel)
        secondVertStack.addArrangedSubview(statusSegmentControl)
        
        backgroundView.addSubview(editButton)
        backgroundView.addSubview(saveButton)
    }
    
    func hideView() {
        nameTextField.isHidden = true
        descriptionTextView.isHidden = true
        secondDateLabel.isHidden = true
        statusSegmentControl.isHidden = true
        saveButton.isHidden = true
    }
}

private extension DetailScreenView {
    func setupConstraints() {
        firstVertStackConstraints = [
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            backgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            firstVertStack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16),
            firstVertStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            firstVertStack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            
            editButton.topAnchor.constraint(equalTo: firstVertStack.bottomAnchor, constant: 16),
            editButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            editButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
        ]
        
        secondVertStackConstraints = [
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            backgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            secondVertStack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 8),
            secondVertStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            secondVertStack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            
            saveButton.topAnchor.constraint(equalTo: firstVertStack.bottomAnchor, constant: 16),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
        ]
        
        NSLayoutConstraint.activate(firstVertStackConstraints)
    }
}

private extension DetailScreenView {
    func addTargetToBttn() {
        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    @objc private func editTapped() {
        onEditTapped?()
    }
    
    @objc private func saveTapped() {
        guard let name = nameTextField.text, !name.isEmpty,
              let description = descriptionTextView.text else { return }
        
        let updatedNote = NoteStruct(
            name: name,
            description: description,
            date: Date(),
            status: true
        )
        
        onSaveTapped?(updatedNote)
    }
}

extension DetailScreenView {
    func setupText(title: String, editBttn: String, saveBttn: String) {
        titleLabel.text = title
        editButton.setTitle(editBttn, for: .normal)
        saveButton.setTitle(saveBttn, for: .normal)
    }
    
    func setupData(with note: NoteStruct) {
        nameLabel.text = note.name
        descriptionLabel.text = note.description
        firstDateLabel.text = note.date.formatted()
        secondDateLabel.text = firstDateLabel.text
        statusLabel.text = note.status ? "Completed" : "Not Completed"
        
        nameTextField.text = note.name
        descriptionTextView.text = note.description
    }
}

extension DetailScreenView {
    func setEditingMode(_ isEditing: Bool) {
        if isEditing {
            NSLayoutConstraint.deactivate(firstVertStackConstraints)
            NSLayoutConstraint.activate(secondVertStackConstraints)
        } else {
            NSLayoutConstraint.deactivate(secondVertStackConstraints)
            NSLayoutConstraint.activate(firstVertStackConstraints)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        
        nameTextField.isHidden = !isEditing
        descriptionTextView.isHidden = !isEditing
        secondDateLabel.isHidden = !isEditing
        statusSegmentControl.isHidden = !isEditing
        saveButton.isHidden = !isEditing
        
        nameLabel.isHidden = isEditing
        descriptionLabel.isHidden = isEditing
        firstDateLabel.isHidden = isEditing
        statusLabel.isHidden = isEditing
        editButton.isHidden = isEditing
    }
}
