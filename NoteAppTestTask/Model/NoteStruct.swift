import Foundation

struct NoteStruct {
    let name: String
    let description: String
    let date: Date
    let status: Bool
    
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
