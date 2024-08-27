import Foundation

enum MainScreenEnum {
    enum MainScreenString {
        static let title = "YOUR TASKS"
        static let completedStatus = "Completed"
        static let notCompletedStatud = "Not completed"
    }
    
    enum MainScreenConstraints {
        static let top: CGFloat = 16
        static let leading: CGFloat = 8
        static let trailing: CGFloat = -8
        static let spacing: CGFloat = 32
    }
    
    enum NoteCellConstraints {
        static let top: CGFloat = 8
        static let leading: CGFloat = 8
        static let trailing: CGFloat = -8
        static let bottom: CGFloat = -8
        
        static let imageSize: CGFloat = 16
    }
}
