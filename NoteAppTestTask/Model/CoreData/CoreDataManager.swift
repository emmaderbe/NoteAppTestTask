import CoreData

import CoreData

protocol CoreDataProtocol {
    func fetchNotes() -> [NoteEntity]
    func addNoteEntity(from note: NoteStruct)
    func updateNoteEntity(_ noteEntity: NoteEntity, with note: NoteStruct)
    func deleteNoteEntity(_ noteEntity: NoteEntity)
}

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let persistentContainer = NSPersistentContainer(name: "CoreData")
    
    private init() {
        loadContainer()
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func loadContainer() {
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                NotificationCenter.default.post(name: .coreDataDidChange, object: nil)
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataManager: CoreDataProtocol {
    func fetchNotes() -> [NoteEntity] {
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch notes: \(error)")
            return []
        }
    }
    
    func addNoteEntity(from note: NoteStruct) {
        let noteEntity = NoteEntity(context: context)
        noteEntity.name = note.name
        noteEntity.descriptions = note.descriptions
        noteEntity.date = note.date
        noteEntity.status = note.status
        saveContext()
    }
    
    func updateNoteEntity(_ noteEntity: NoteEntity, with note: NoteStruct) {
        noteEntity.name = note.name
        noteEntity.descriptions = note.descriptions
        noteEntity.date = note.date
        noteEntity.status = note.status
        saveContext()
    }
    
    func deleteNoteEntity(_ noteEntity: NoteEntity) {
        context.delete(noteEntity)
        saveContext()
    }
}

extension NSNotification.Name {
    static let coreDataDidChange = NSNotification.Name("coreDataDidChange")
}
