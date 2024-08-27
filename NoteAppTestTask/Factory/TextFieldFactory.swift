import UIKit

final class TextFieldFactory {
    static func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}
