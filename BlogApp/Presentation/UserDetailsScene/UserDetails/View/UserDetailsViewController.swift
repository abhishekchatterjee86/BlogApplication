//
//  UserDetailsViewController.swift
//  BlogApp
//
//  Created by Abhishek on 21/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import UIKit

final class UserDetailsViewController: UIViewController, StoryboardInstantiable {
  
  @IBOutlet private var avatarImageView: UIImageView!
  @IBOutlet private var userNameTextLabel: UILabel!
  @IBOutlet private var designationTextLabel: UILabel!
  @IBOutlet private var cityTextLabel: UILabel!
  @IBOutlet private var descriptionTextLabel: UILabel!
  
  private var viewModel: UserDetailsViewModel!
  
  static func create(with viewModel: UserDetailsViewModel) -> UserDetailsViewController {
    let view = UserDetailsViewController.instantiateViewController()
    view.viewModel = viewModel
    return view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bind(to: viewModel)
  }
  
  private func bind(to viewModel: UserDetailsViewModel) {
    userNameTextLabel.text = viewModel.userName
    designationTextLabel.text = viewModel.userDesignation
    cityTextLabel.text = viewModel.city
    descriptionTextLabel.text = viewModel.userDescription

    viewModel.avatarImage.observe(on: self) { [weak self] in self?.avatarImageView.image = $0.flatMap(UIImage.init) }
    avatarImageView.isHidden = viewModel.isAvatarImageHidden
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    viewModel.updateAvatarImage()
  }
}
