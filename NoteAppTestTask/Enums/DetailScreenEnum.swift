import Foundation

enum DetailScreenEnum {
    enum DetailScreenString {
        static let title = "DETAIL INFO"
        static let editButton = "EDIT TASK"
        static let saveButton =  "SAVE TASK"
        
        static let titleAlert = "Ooops!"
        static let messageAlert = "Please, add task name :)"
        
        static let trueSegmentControl = "Completed"
        static let falseSegmentControl = "Not Completed"
    }
    
    enum DetailScreenConstraints {
        static let top: CGFloat = 8
        static let leading: CGFloat = 16
        static let trailing: CGFloat = -16
        static let spacing: CGFloat = 16
        static let heightTextView: CGFloat = 200
    }
}
