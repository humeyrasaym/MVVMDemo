//
//  ListRepostory.swift
//  HumeyraSayim
//
//  Created by Hümeyra SAYIM on 2/2/25.
//

import Foundation


class ListRepository {
    
    //MARK: - Properties
    private var networkManager: NetworkManager? = NetworkManager()

    func execute(completionHandler: @escaping ((Result<[ListModel],Error>) -> Void)) {
        networkManager?.fetchUserList { result in
            switch result {
            case .success(let users):
                completionHandler(.success(users.map({ ListModel(userId: $0.id, userName: $0.name, userEmail: $0.email)})))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
       
    }
}

