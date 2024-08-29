import Foundation

protocol NetworkServiceProtocol {
    func fetchTodos(completion: @escaping (Result<[NoteStruct], Error>) -> Void)
}

enum NetworkError: Error {
    case invalidURL
    case clientError
    case serverError
    case noResults
    case unknown
}

final class NetworkService: NetworkServiceProtocol {
    private let urlSession = URLSession.shared
    
    func fetchTodos(completion: @escaping (Result<[NoteStruct], Error>) -> Void) {
        guard let request = makeTodosRequest() else {
            DispatchQueue.main.async {
                completion(.failure(NetworkError.invalidURL))
            }
            return
        }
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            self.handleResponse(data: data, response: response, error: error) { (result: Result<TaskResponse, Error>) in
                switch result {
                case .success(let categoryResponse):
                    let notes = categoryResponse.todos.map { todoDTO in
                        NoteStruct(
                            name: todoDTO.todo,
                            descriptions: "",
                            date: Date(),
                            status: todoDTO.completed
                        )
                    }
                    DispatchQueue.main.async {
                        completion(.success(notes))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
}

private extension NetworkService {
    func makeTodosRequest() -> URLRequest? {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            return nil
        }
        return URLRequest(url: url)
    }

    func handleResponse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<T, Error>) -> Void) {
        guard let httpResponse = response as? HTTPURLResponse else {
            DispatchQueue.main.async {
                completion(.failure(NetworkError.unknown))
            }
            return
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NetworkError.unknown))
            }
        case 400...499:
            completion(.failure(NetworkError.clientError))
        case 500...599:
            completion(.failure(NetworkError.serverError))
        default:
            completion(.failure(NetworkError.unknown))
        }
    }
}
