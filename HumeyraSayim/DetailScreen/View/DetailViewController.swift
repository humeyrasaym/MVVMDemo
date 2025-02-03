//
//  DetailViewController.swift
//  HumeyraSayim
//
//  Created by Hümeyra SAYIM on 2/3/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - UI Elements
    
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    //MARK: - Properties
    var viewModel: DefaultDetailViewModel? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModelSubscription()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.fetchData()
    }
    
    /// fetches view model actions
    func viewModelSubscription() {
        viewModel?.fetchData()
        viewModel?.didFinish = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.setupUI()
            }
        }
        
    }
    
    func setupUI() {
        nameLabel?.text = viewModel?.userdata?.userName
        mailLabel?.text = viewModel?.userdata?.userEmail
        phoneLabel?.text = viewModel?.userdata?.phone
        websiteLabel?.text = viewModel?.userdata?.website
        
    }
    
}
