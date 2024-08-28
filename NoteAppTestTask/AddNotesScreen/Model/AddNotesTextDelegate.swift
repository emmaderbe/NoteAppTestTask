import UIKit

final class AddNotesTextDelegate: NSObject {
    weak var view: UIView?
    
    init(view: UIView) {
        self.view = view
    }
}

extension AddNotesTextDelegate: UITextFieldDelegate, UITextViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if newText.count <= 50 {
            if let screenView = view as? AddNotesScreenViewProtocol {
                screenView.updateNameCounter(remaining: 50 - newText.count)
            }
            return true
        }
        return false
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        if newText.count <= 120 {
            if let screenView = view as? AddNotesScreenViewProtocol {
                screenView.updateDescriptionCounter(remaining: 120 - newText.count)
            }
            return true
        }
        return false
    }
}
