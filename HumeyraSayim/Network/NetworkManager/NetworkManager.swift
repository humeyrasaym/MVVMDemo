//
//  NetworkManager.swift
//  HumeyraSayim
//
//  Created by Hümeyra SAYIM on 2/2/25.
//

import Foundation

class NetworkManager {
    
    /// Fetches the user list from the API
    func fetchUserList(completion: @escaping ((Result<[ListResponseModel], Error>) -> Void)) {
        
        let urlString = "https://jsonplaceholder.typicode.com/users"
        
        /// Calls the generic ⁠ performRequest ⁠ method to fetch data
        performRequest(with: urlString) { (result: (Result<[ListResponseModel], Error>)) in
            completion(result)
        }
    }
    /// performs a network request and decodes the response into a specified codable type
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
                        /// attempt to decode the data into the specified generic type
                        let decodedData = try decoder.decode(T.self, from: safeData)
                        
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            /// 4. start the task
            task.resume()
        }
    }
    
}
