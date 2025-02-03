//
//  ListViewController.swift
//  HumeyraSayim
//
//  Created by Hümeyra SAYIM on 2/1/25.
//

import UIKit

class ListViewController: ViewController {
    
    //MARK: - Properties
    /// view model
    var viewModel = DefaultListViewModel()
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModelSubscription()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchData()
    }
    
    
    /// settings ui elements
    func setupUI() {
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        listTableView.register(UINib(nibName: "UserListTableViewCell", bundle: nil), forCellReuseIdentifier: "UserListTableViewCell")
        
    }
    
    /// fetches view model actions
    func viewModelSubscription() {
        viewModel.fetchData()
        viewModel.didFinish = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
        
    }
    
    func setupUserListCell(username: String?, usermail: String?) -> UITableViewCell {
        // Dequeue a reusable cell as an instance of ProductDetailNameCell for the given index path.
        let cell = listTableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell") as? UserListTableViewCell
        
        // Configure the cell with the provided product details.
        cell?.setupData(userName: username, useremail: usermail)
        
        // Return the cell, or a new UITableViewCell if the cell is nil.
        return cell ?? UITableViewCell()
    }
}


extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = viewModel.userList?[indexPath.row]
        return setupUserListCell(username: user?.userName, usermail: user?.userEmail)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserListTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = viewModel.userList?[indexPath.row]
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        let detailVC = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        //let detailVC = DetailViewController()
        detailVC?.viewModel = DefaultDetailViewModel(userId: selectedUser?.userId ?? 0)
        
        self.navigationController?.pushViewController(detailVC!, animated: true)
    }
    
    
}
