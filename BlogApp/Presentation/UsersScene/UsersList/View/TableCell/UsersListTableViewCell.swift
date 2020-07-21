//
//  UsersListTableViewCell.swift
//  BlogApp
//
//  Created by Abhishek on 21/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import UIKit

class UsersListTableViewCell: UITableViewCell {
  static let reuseIdentifier = String(describing: UsersListTableViewCell.self)
  
  @IBOutlet private var cityLabel: UILabel!
  @IBOutlet private var userNameLabel: UILabel!
  @IBOutlet private var userDesignationLabel: UILabel!
  
  private var viewModel: UserViewModel!
  
  func fill(with viewModel: UserViewModel) {
    self.viewModel = viewModel
    
    userNameLabel.text = viewModel.userName
    userDesignationLabel.text = viewModel.userDesignation
    cityLabel.text = viewModel.city
  }
}
