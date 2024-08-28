import UIKit

final class NoteCollectionDataSource: NSObject, UICollectionViewDataSource {
    weak var delegate: NoteCollectionDelegateProtocol?
    private var notes: [NoteStruct] = []
}

extension NoteCollectionDataSource {
    func updateNotes(_ notes: [NoteStruct]) {
        self.notes = notes
    }
}

extension NoteCollectionDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionViewCell.identifier, for: indexPath) as? NoteCollectionViewCell
        else { return UICollectionViewCell() }
        let note = notes[indexPath.row]
        cell.setupText(with: note)
        
        cell.onDeleteTapped = { [weak self] in
            guard let self = self else { return }
            let index = indexPath.row
            
            UIView.animate(withDuration: 0.3, animations: {
                cell.alpha = 0
                cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { _ in
                self.notes.remove(at: index)
                collectionView.performBatchUpdates({
                    collectionView.deleteItems(at: [indexPath])
                }, completion: nil)
                self.delegate?.deleteNoteAt(index: index)
            })
        }
        return cell
    }
}
