import UIKit

final class NoteCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    private var notes: [String] = []
}

extension NoteCollectionDataSource {
    func updateNotes(_ notes: [String]) {
        self.notes = notes
    }
}

extension NoteCollectionDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    // add cell.configure
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionViewCell.identifier, for: indexPath) as? NoteCollectionViewCell
        else { return UICollectionViewCell() }
        let note = notes[indexPath.row]
        return cell
    }
}
