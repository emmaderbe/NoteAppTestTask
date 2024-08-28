import UIKit

protocol NoteTextDelegateProtocol: AnyObject {
    func updateNameCounter(remaining: Int)
    func updateDescriptionCounter(remaining: Int)
    func updateCounters()
}

final class NotesTextDelegate: NSObject {
    weak var view: UIView?
    
    init(view: UIView) {
        self.view = view
    }
}

extension NotesTextDelegate: UITextFieldDelegate, UITextViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        let newText = currentText.replacingCharacters(in: range, with: string)
        
        if string.isEmpty {
            if let screenView = view as? NoteTextDelegateProtocol {
                screenView.updateNameCounter(remaining: 50 - newText.count)
            }
            return true
        }
        
        if newText.count <= 50 {
            if let screenView = view as? NoteTextDelegateProtocol {
                screenView.updateNameCounter(remaining: 50 - newText.count)
            }
            return true
        }
        return false
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let currentText = textView.text as NSString? else { return true }
        let newText = currentText.replacingCharacters(in: range, with: text)

        if text.isEmpty {
            if let screenView = view as? NoteTextDelegateProtocol {
                screenView.updateDescriptionCounter(remaining: 120 - newText.count)
            }
            return true
        }
        
        if newText.count <= 120 {
            if let screenView = view as? NoteTextDelegateProtocol {
                screenView.updateDescriptionCounter(remaining: 120 - newText.count)
            }
            return true
        }

        return false
    }
}
