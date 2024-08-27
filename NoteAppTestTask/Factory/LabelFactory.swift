import UIKit

final class LabelFactory {
    static func createSuperTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 42, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createOrdinaryLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createSubOrdinaryLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
