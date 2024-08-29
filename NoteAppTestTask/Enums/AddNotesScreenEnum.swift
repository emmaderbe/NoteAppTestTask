import Foundation

enum AddNotesScreenEnum {
    enum AddNotesString {
        static let title = "CREATE A NEW TASK"
        static let noteName = "NAME"
        static let noteNamePlaceHolder =  ""
        static let noteDescription =  "DESCRIPTION"
        static let buttonTitle = "SAVE A TASK"
        
        static let titleAlert = "Ooops!"
        static let messageAlert = "Please, add task name :)"
    }
    
    enum AddScreenConstraints {
        static let leading: CGFloat = 16
        static let trailing: CGFloat = -16
        static let spacing: CGFloat = 16
        static let heightTextView: CGFloat = 200
    }
}
