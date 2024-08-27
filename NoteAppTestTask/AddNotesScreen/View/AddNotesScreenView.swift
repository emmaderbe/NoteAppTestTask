import UIKit

final class AddNotesScreenView: UIView {
    private let titleLabel = LabelFactory.createSuperTitleLabel()
    private let backgroundView = ViewFactory.backgroundView(cornerRadius: 16)
    private let firstHorzStack = StackFactory.createHorizontalStack(spacing: 8)
    
    private let noteNameLabel = LabelFactory.createOrdinaryLabel()
    private let noteNameTextField = TextFieldFactory.createTextField(placeholder: "")
    private let secondHorzStack = StackFactory.createHorizontalStack(spacing: 4)
    
    
    private let descriptionLabel = LabelFactory.createOrdinaryLabel()
    private let descriptionTextView = TextViewFactory.createTextView()
    private let thirdHorzStack = StackFactory.createHorizontalStack(spacing: 4)
    
    private let saveButton =  ButtonFactory.createSavedButton(title: "")
    
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
        secondHorzStack.addArrangedSubview(noteNameTextField)
        
        thirdHorzStack.addArrangedSubview(descriptionLabel)
        thirdHorzStack.addArrangedSubview(descriptionTextView)
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
}

private extension AddNotesScreenView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            backgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            firstHorzStack.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 8),
            firstHorzStack.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 8),
            firstHorzStack.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -8),
            
            saveButton.topAnchor.constraint(equalTo: firstHorzStack.bottomAnchor, constant: 32),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
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
