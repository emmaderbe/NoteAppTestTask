import Foundation
import CoreData


extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var date: Date?
    @NSManaged public var status: Bool

}

extension NoteEntity : Identifiable {

}
