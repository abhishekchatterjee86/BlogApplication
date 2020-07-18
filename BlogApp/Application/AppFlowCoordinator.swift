//
//  AppFlowCoordinator.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import UIKit

class AppFlowCoordinator {
  
  var navigationController: UINavigationController
  private let appDIContainer: AppDIContainer
  
  init(navigationController: UINavigationController,
       appDIContainer: AppDIContainer) {
    self.navigationController = navigationController
    self.appDIContainer = appDIContainer
  }
  
  func start() {
    let articlesSceneDIContainer = appDIContainer.makeArticlesSceneDIContainer()
    let flow = articlesSceneDIContainer.makeArticlesListFlowCoordinator(navigationController: navigationController)
    flow.start()
  }
}
