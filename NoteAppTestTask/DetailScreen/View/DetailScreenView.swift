import UIKit

final class DetailScreenView: UIView {
    private let titleLabel = LabelFactory.createSuperTitleLabel()
    private let backgroundView = ViewFactory.backgroundView(cornerRadius: 16)
    
    private let nameLabel = LabelFactory.createDetailTitleLabel()
    private let descriptionLabel = LabelFactory.createOrdinaryLabel()
    private let firstDateLabel = LabelFactory.createSubOrdinaryLabel()
    private let statusLabel = LabelFactory.createSubOrdinaryLabel()
    private let firstVertStack = StackFactory.createVerticalStack(spacing: 8)
    
    private let nameTextField = TextViewFactory.createTextView()
    private let descriptionTextView = TextViewFactory.createTextView()
    private let secondDateLabel = LabelFactory.createSubOrdinaryLabel()
    private let statusSegmentControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.insertSegment(withTitle: DetailScreenEnum.DetailScreenString.falseSegmentControl, at: 0, animated: false)
        segment.insertSegment(withTitle: DetailScreenEnum.DetailScreenString.trueSegmentControl, at: 1, animated: false)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    private let secondVertStack = StackFactory.createVerticalStack(spacing: 8)
    
    private let editButton = ButtonFactory.createBlueButton(title: "")
    private let saveButton = ButtonFactory.createBlueButton(title: "")
    
    private var firstVertStackConstraints: [NSLayoutConstraint] = []
    private var secondVertStackConstraints: [NSLayoutConstraint] = []
    
    var onEditTapped: (() -> Void)?
    var onSaveTapped: (() -> Void)?
    
    private var existingDate: Date? = nil
    
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
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: DetailScreenEnum.DetailScreenConstraints.top),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DetailScreenEnum.DetailScreenConstraints.leading),
            
            backgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: DetailScreenEnum.DetailScreenConstraints.spacing),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            firstVertStack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: DetailScreenEnum.DetailScreenConstraints.spacing),
            firstVertStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: DetailScreenEnum.DetailScreenConstraints.leading),
            firstVertStack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: DetailScreenEnum.DetailScreenConstraints.trailing),
            
            editButton.topAnchor.constraint(equalTo: firstVertStack.bottomAnchor, constant: DetailScreenEnum.DetailScreenConstraints.spacing),
            editButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            editButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
        ]
        
        secondVertStackConstraints = [
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: DetailScreenEnum.DetailScreenConstraints.top),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DetailScreenEnum.DetailScreenConstraints.leading),
            
            backgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: DetailScreenEnum.DetailScreenConstraints.spacing),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            secondVertStack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: DetailScreenEnum.DetailScreenConstraints.spacing),
            secondVertStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: DetailScreenEnum.DetailScreenConstraints.leading),
            secondVertStack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: DetailScreenEnum.DetailScreenConstraints.trailing),
            
            saveButton.topAnchor.constraint(equalTo: secondVertStack.bottomAnchor, constant: DetailScreenEnum.DetailScreenConstraints.spacing),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            
            descriptionTextView.heightAnchor.constraint(equalToConstant: DetailScreenEnum.DetailScreenConstraints.heightTextView),
            nameTextField.heightAnchor.constraint(equalTo: descriptionTextView.heightAnchor, multiplier: 0.5),
        ]
        
        NSLayoutConstraint.activate(firstVertStackConstraints)
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
        firstDateLabel.text = note.formattedDate()
        secondDateLabel.text = firstDateLabel.text
        existingDate = note.date
        statusLabel.text = note.status ? DetailScreenEnum.DetailScreenString.trueSegmentControl : DetailScreenEnum.DetailScreenString.falseSegmentControl
        
        nameTextField.text = note.name
        descriptionTextView.text = note.description
        if statusLabel.text == DetailScreenEnum.DetailScreenString.trueSegmentControl {
            statusSegmentControl.selectedSegmentIndex = 1
        } else {
            statusSegmentControl.selectedSegmentIndex = 0
        }
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

private extension DetailScreenView {
    func addTargetToBttn() {
        editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    
    @objc private func editTapped() {
        onEditTapped?()
    }
    
    @objc private func saveTapped() {
        onSaveTapped?()
    }
}

extension DetailScreenView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension DetailScreenView {
    func getNoteName() -> String? {
        return nameTextField.text
    }
    
    func getNoteDescription() -> String? {
        return descriptionTextView.text
    }
    
    func getStatus() -> Bool {
        return statusSegmentControl.selectedSegmentIndex == 1
    }
    
    func getDate() -> Date {
        return existingDate ?? Date()
    }
}
