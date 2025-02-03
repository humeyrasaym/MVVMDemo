//
//  DetailViewModel.swift
//  HumeyraSayim
//
//  Created by Hümeyra SAYIM on 2/3/25.
//

import UIKit

protocol DetailViewModel {
    
    /// The model containing user data that the ViewModel works with
    var userdata: DetailModel? { get set }
    
    /// The repository used to fetch data
    var repository: DetailRepository? { get set }
    
    /// checks if the data operations done or not for updating ui elements
    var didFinish: ( () -> Void )? { get set }
    
    /// if is there any error, it shows the error with string handler
    var didFinishWithError: ( () -> Void )? { get set }
    
    /// Fetches data by the view model
    func fetchData()
}

class DefaultDetailViewModel: DetailViewModel {
    
    //MARK: - Properties
    private var detailRepository: DetailRepository?
    
    var userdata: DetailModel?
    
    var repository: DetailRepository? = DetailRepository()
    
    var didFinish: (() -> Void)?
    
    var didFinishWithError: (() -> Void)?
    
    private let userId: Int
    
    /// Initializes the ViewModel with a userId
    init(userId: Int) {
        self.userId = userId
    }
    
    func fetchData() {
        /// Call the repository to fetch data for the given userId
        repository?.execute(userId: self.userId) { [weak self] result in
            switch result {
            case .success(let user):
                self?.userdata = user
                print(user)
                self?.didFinish?()
            case .failure:
                self?.didFinishWithError?()
            }
        }
    }
}
