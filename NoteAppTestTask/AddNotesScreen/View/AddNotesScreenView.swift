import UIKit

final class AddNotesScreenView: UIView {
    private let titleLabel = LabelFactory.createSuperTitleLabel()
    private let backgroundView = ViewFactory.backgroundView(cornerRadius: 16)
    private let firstHorzStack = StackFactory.createVerticalStack(spacing: 16)
    
    private let noteNameLabel = LabelFactory.createTitleLabel()
    private let noteNameTextField = TextFieldFactory.createTextField(placeholder: "")
    private let noteNameCounterLabel = LabelFactory.createSubOrdinaryLabel()
    private let secondHorzStack = StackFactory.createVerticalStack(spacing: 8)
    
    
    private let descriptionLabel = LabelFactory.createTitleLabel()
    private let descriptionTextView = TextViewFactory.createTextView()
    private let descriptionCounterLabel = LabelFactory.createSubOrdinaryLabel()
    private let thirdHorzStack = StackFactory.createVerticalStack(spacing: 8)
    
    private let saveButton =  ButtonFactory.createSavedButton(title: "")
    
    var onBttnTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupDelegates()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddNotesScreenView {
    func setupView() {
        backgroundColor = .systemBlue
        
        addSubview(titleLabel)
        addSubview(backgroundView)
        
        backgroundView.addSubview(firstHorzStack)
        backgroundView.addSubview(saveButton)
        
        firstHorzStack.addArrangedSubview(secondHorzStack)
        firstHorzStack.addArrangedSubview(thirdHorzStack)
        
        secondHorzStack.addArrangedSubview(noteNameLabel)
        secondHorzStack.addArrangedSubview(noteNameCounterLabel)
        secondHorzStack.addArrangedSubview(noteNameTextField)
        
        thirdHorzStack.addArrangedSubview(descriptionLabel)
        thirdHorzStack.addArrangedSubview(descriptionCounterLabel)
        thirdHorzStack.addArrangedSubview(descriptionTextView)
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    func setupDelegates() {
        noteNameTextField.delegate = self
        descriptionTextView.delegate = self
    }
}

private extension AddNotesScreenView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AddNotesScreenEnum.AddScreenConstraints.leading),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: AddNotesScreenEnum.AddScreenConstraints.trailing),
            
            backgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: AddNotesScreenEnum.AddScreenConstraints.spacing),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            firstHorzStack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: AddNotesScreenEnum.AddScreenConstraints.spacing),
            firstHorzStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: AddNotesScreenEnum.AddScreenConstraints.leading),
            firstHorzStack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: AddNotesScreenEnum.AddScreenConstraints.trailing),
            
            saveButton.topAnchor.constraint(equalTo: firstHorzStack.bottomAnchor, constant: AddNotesScreenEnum.AddScreenConstraints.spacing * 2),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            
            descriptionTextView.heightAnchor.constraint(equalToConstant: AddNotesScreenEnum.AddScreenConstraints.heightTextView),
            
        ])
    }
}

private extension AddNotesScreenView {
    @objc func saveButtonTapped() {
        onBttnTapped?()
    }
}

extension AddNotesScreenView {
    func setupText(title: String,
                   noteName: String,
                   noteNamePlaceHolder: String,
                   noteDescription: String,
                   buttonTitle: String
    ) {
        titleLabel.text = title
        noteNameLabel.text = noteName
        noteNameTextField.placeholder = noteNamePlaceHolder
        descriptionLabel.text = noteDescription
        saveButton.setTitle(buttonTitle, for: .normal)
    }
    
    func setupRemaining(name: String, description: String) {
        noteNameCounterLabel.text = name
        descriptionCounterLabel.text = description
    }
}

extension AddNotesScreenView {
    func noteTextFieldIsEmpty() -> Bool {
        return noteNameTextField.text?.isEmpty ?? true
    }
    
    func getNoteName() -> String? {
        return noteNameTextField.text
    }
    
    func getNoteDescription() -> String? {
        return descriptionTextView.text
    }
}

extension AddNotesScreenView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if newText.count <= 50 {
            noteNameCounterLabel.text = "Remaining: \(50 - newText.count)"
            return true
        }
        return false
    }
}

extension AddNotesScreenView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        if newText.count <= 120 {
            descriptionCounterLabel.text = "Remaining: \(120 - newText.count)"
            return true
        }
        return false
    }
}
