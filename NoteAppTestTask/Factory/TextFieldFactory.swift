import UIKit

final class TextFieldFactory {
    static func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textAlignment = .center
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}
