//
//  ArticlesListFlowCoordinator.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import UIKit

protocol ArticlesListFlowCoordinatorDependencies  {
  func makeArticlesListViewController(closures: ArticlesListViewModelClosures) -> ArticlesListViewController
  func makeUsersListViewController(closures: UsersListViewModelClosures) -> UsersListViewController
  func makeUserDetailsViewController(user: User) -> UIViewController
}

class ArticlesListFlowCoordinator {
  
  private weak var navigationController: UINavigationController?
  private let dependencies: ArticlesListFlowCoordinatorDependencies
  
  private weak var cityListVC: ArticlesListViewController?
  
  init(navigationController: UINavigationController,
       dependencies: ArticlesListFlowCoordinatorDependencies) {
    self.navigationController = navigationController
    self.dependencies = dependencies
  }
  
  func start() {
    let closures = ArticlesListViewModelClosures(showUsersList: showUsersList,
                                                 showUserDetails: showUserDetails)
    let vc = dependencies.makeArticlesListViewController(closures: closures)
    
    navigationController?.pushViewController(vc, animated: false)
    cityListVC = vc
  }
  
  private func showUsersList() {
    let closures = UsersListViewModelClosures()
    
    let vc = dependencies.makeUsersListViewController(closures: closures)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  private func showUserDetails(user: User) {
    let vc = dependencies.makeUserDetailsViewController(user: user)
    navigationController?.pushViewController(vc, animated: true)
  }
}
