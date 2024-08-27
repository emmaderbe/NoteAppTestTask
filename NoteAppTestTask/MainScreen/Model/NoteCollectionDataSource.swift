import UIKit

final class NoteCollectionDataSource: NSObject, UICollectionViewDataSource {
    
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
        return cell
    }
}
