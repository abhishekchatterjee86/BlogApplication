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
    let imageDataTransferService: DataTransferService
  }
  
  private let dependencies: Dependencies
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
  
  // MARK: - Use Cases
  func makeFetchArticlesUseCase() -> FetchArticlesUseCase {
    return DefaultFetchArticlesUseCase(articlesRepository: makeArticlesListRepository())
  }
  
  // MARK: - Repositories
  func makeArticlesListRepository() -> ArticlesListRepository {
    return DefaultArticlesListRepository(dataTransferService: dependencies.apiDataTransferService)
  }
  
  func makeImagesRepository() -> ImagesRepository {
      return DefaultImagesRepository(dataTransferService: dependencies.imageDataTransferService)
  }
  
  // MARK: - Articles List
  func makeArticlesListViewController(closures: ArticlesListViewModelClosures) -> ArticlesListViewController {
    return ArticlesListViewController.create(with: makeArticlesListViewModel(closures: closures), imagesRepository: makeImagesRepository())
  }
  
  func makeArticlesListViewModel(closures: ArticlesListViewModelClosures) -> ArticlesListViewModel {
    return DefaultArticlesListViewModel(articlesUseCase: makeFetchArticlesUseCase())
  }
  
  // MARK: - Flow Coordinators
  func makeArticlesListFlowCoordinator(navigationController: UINavigationController) -> ArticlesListFlowCoordinator {
    return ArticlesListFlowCoordinator(navigationController: navigationController,
                                       dependencies: self)
  }
}

extension ArticlesSceneDIContainer: ArticlesListFlowCoordinatorDependencies {}
