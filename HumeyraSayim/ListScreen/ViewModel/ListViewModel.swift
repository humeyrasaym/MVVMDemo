//
//  ListViewModel.swift
//  HumeyraSayim
//
//  Created by Hümeyra SAYIM on 2/1/25.
//

import UIKit

protocol ListViewModel {
    
    /// List of users
    var userList: [ListModel]? { get }
    
    var repository: ListRepository? { get set }
    
    /// checks if the data operations done or not for updating ui elements
    var didFinish: ( () -> Void )? { get set }
    
    /// if is there any error, it shows the error with string handler
    var didFinishWithError: ( () -> Void )? { get set }
    
    /// Fetches data by the view model
    func fetchData()
    
}

class DefaultListViewModel: ListViewModel {
    
    /// Handles all network requests for fetching and updating product data.
    private var listRepository: ListRepository?

    var repository: ListRepository? = ListRepository()
    
    var userList: [ListModel]? = []
    
    var didFinish: ( () -> Void )?
    
    var didFinishWithError: ( () -> Void )?
    
    func fetchData() {
        repository?.execute { [weak self] result in
                    switch result {
                    case .success(let users):
                        self?.userList = users
                        print(users)
                        self?.didFinish?()
                    case .failure:
                        self?.didFinishWithError?()
                    }
        }
    }
    
}
