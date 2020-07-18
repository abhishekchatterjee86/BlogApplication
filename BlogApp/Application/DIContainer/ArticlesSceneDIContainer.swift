//
//  ArticlesSceneDIContainer.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import UIKit

final class ArticlesSceneDIContainer {
  
  struct Dependencies {
    let apiDataTransferService: DataTransferService
  }
  
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
  
  // MARK: - Movies List
  func makeArticlesListViewController(closures: ArticlesListViewModelClosures) -> ArticlesListViewController {
      return ArticlesListViewController.create(with: makeArticlesListViewModel(closures: closures))
  }
  
  func makeArticlesListViewModel(closures: ArticlesListViewModelClosures) -> ArticlesListViewModel {
    return DefaultArticlesListViewModel()
  }
  
  // MARK: - Flow Coordinators
  func makeArticlesListFlowCoordinator(navigationController: UINavigationController) -> ArticlesListFlowCoordinator {
    return ArticlesListFlowCoordinator(navigationController: navigationController,
                                       dependencies: self)
  }
}

extension ArticlesSceneDIContainer: ArticlesListFlowCoordinatorDependencies {}
