//
//  DetailViewModel.swift
//  HumeyraSayim
//
//  Created by Hümeyra SAYIM on 2/3/25.
//

import UIKit

protocol DetailViewModel {
    
    var userdata: DetailModel? { get set }
    var repository: DetailRepository? { get set }
    
    /// checks if the data operations done or not for updating ui elements
    var didFinish: ( () -> Void )? { get set }
    
    /// if is there any error, it shows the error with string handler
    var didFinishWithError: ( () -> Void )? { get set }
    
    /// Fetches data by the view model
    func fetchData()
}

class DefaultDetailViewModel: DetailViewModel {
    
    private var detailRepository: DetailRepository?
    
    var userdata: DetailModel?
    
    var repository: DetailRepository? = DetailRepository()
    
    var didFinish: (() -> Void)?
    
    var didFinishWithError: (() -> Void)?
    
    private let userId: Int
        
        init(userId: Int) {
            self.userId = userId
        }
    
    func fetchData() {
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
