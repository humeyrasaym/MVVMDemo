//
//  UserListTableViewCell.swift
//  HumeyraSayim
//
//  Created by Hümeyra SAYIM on 2/3/25.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    //MARK: - UI Elements
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    //MARK: - Properties
    private var model: ListModel?
    static var height: CGFloat = UITableView.automaticDimension

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// Configures the cell with user data
    func setupData(userName: String?, useremail: String?) {
        emailLabel.text = useremail
        nameLabel.text = userName
        
    }
    
}
