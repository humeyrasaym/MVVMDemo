//
//  DetailRepository.swift
//  HumeyraSayim
//
//  Created by Hümeyra SAYIM on 2/3/25.
//

import Foundation

class DetailRepository {
    
    //MARK: - Properties
    private var networkManager: NetworkManager? = NetworkManager()
    
    func execute(userId: Int, completionHandler: @escaping ((Result<DetailModel,Error>) -> Void)) {
        /// Fetch the user list using the network manager
        networkManager?.fetchUserList { result in
            switch result {
                /// If successful, find the user with the matching userId
            case .success(let users):
                if let user = users.first(where: { $0.id == userId }) {
                    let userModel = DetailModel(
                        userId: user.id,
                        userName: user.name,
                        userEmail: user.email,
                        phone: user.phone,
                        website: user.website
                    )
                    completionHandler(.success(userModel))
                } else {
                    completionHandler(.failure(NSError(domain: "UserNotFound", code: 404, userInfo: nil)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
        
    }
    
}
