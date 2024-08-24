import UIKit

final class ViewFactory {
    static func backgroundView(cornerRadius: CGFloat) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
