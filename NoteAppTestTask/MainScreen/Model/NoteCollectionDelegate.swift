import UIKit

protocol NoteCollectionDelegateProtocol: AnyObject {
    func noteSelected(at index: Int)
    func deleteNoteAt(index: Int)
}

final class NoteCollectionDelegate: NSObject, UICollectionViewDelegate {
    private var notes: [NoteStruct] = []
    weak var delegate: NoteCollectionDelegateProtocol?
}

extension NoteCollectionDelegate {
    func updateNotes(_ notes: [NoteStruct]) {
        self.notes = notes
    }
}

extension NoteCollectionDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < notes.count else { return }
        delegate?.noteSelected(at: indexPath.row)
    }
}

extension NoteCollectionDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360,
                      height: 140)
    }
}
