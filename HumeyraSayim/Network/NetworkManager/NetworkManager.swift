//
//  NetworkManager.swift
//  HumeyraSayim
//
//  Created by Hümeyra SAYIM on 2/2/25.
//

import Foundation

class NetworkManager {
    
    func fetchUserList(completion: @escaping ((Result<[ListResponseModel], Error>) -> Void)) {
        
        let urlString = "https://jsonplaceholder.typicode.com/users"
        
        performRequest(with: urlString) { (result: (Result<[ListResponseModel], Error>)) in
            completion(result)
        }
    }
    
    func performRequest<T: Codable>(with urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        /// 1. create url
        if let url = URL(string: urlString) {
            
            /// 2. create url session
            let session = URLSession(configuration: .default)
            
            /// 3. give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(T.self, from: safeData)
                    
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            
            // 4. start the task
            task.resume()
        }
    }
    
}
