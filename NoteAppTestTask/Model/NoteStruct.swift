import Foundation

struct NoteStruct {
    let name: String
    let descriptions: String
    let date: Date
    let status: Bool
}

extension NoteStruct {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
