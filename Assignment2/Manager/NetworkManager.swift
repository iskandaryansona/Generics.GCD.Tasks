//
//  NetworkManager.swift
//  Assignment2
//
//  Created by Sona on 28.09.24.
//

import Foundation

// MARK: - NetworkManager
class NetworkManager {
    
    private let baseURL = "https://randomuser.me/api/"
    typealias APIResult<T> = Swift.Result<T, Error>
    
    static var shared = NetworkManager()
    
    private init(){}
    
    func fetchUsers(page: Int, results: Int, completion: @escaping (APIResult<DataResponse>) -> Void) {
        let urlString = "\(baseURL)?page=\(page)&results=\(results)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            do {
                let userData = try JSONDecoder().decode(DataResponse.self, from: data)
                completion(.success(userData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
