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
    let closures = ArticlesListViewModelClosures(showUsersList: showUsersList)
    let vc = dependencies.makeArticlesListViewController(closures: closures)

    navigationController?.pushViewController(vc, animated: false)
    cityListVC = vc
  }
  
  private func showUsersList() {

  }
}
