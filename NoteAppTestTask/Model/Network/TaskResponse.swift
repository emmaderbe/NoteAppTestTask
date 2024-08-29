import Foundation

struct TaskResponse: Codable {
    let todos: [ToDo]
    let total: Int
    let skip: Int
    let limit: Int
}

struct ToDo: Codable {
    let id: Int
    let todo: String
    let completed: Bool
}
