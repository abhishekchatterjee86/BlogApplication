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
  
  func makeFetchUsersUseCase() -> FetchUsersUseCase {
    return DefaultFetchUsersUseCase(usersListRepository: makeUsersListRepository())
  }
  
  // MARK: - Repositories
  func makeArticlesListRepository() -> ArticlesListRepository {
    return DefaultArticlesListRepository(dataTransferService: dependencies.apiDataTransferService)
  }
  
  func makeImagesRepository() -> ImagesRepository {
      return DefaultImagesRepository(dataTransferService: dependencies.imageDataTransferService)
  }
  
  func makeUsersListRepository() -> UsersListRepository {
    return DefaultUsersListRepository(dataTransferService: dependencies.apiDataTransferService)
  }
  
  // MARK: - Articles List
  func makeArticlesListViewController(closures: ArticlesListViewModelClosures) -> ArticlesListViewController {
    return ArticlesListViewController.create(with: makeArticlesListViewModel(closures: closures), imagesRepository: makeImagesRepository())
  }
  
  func makeArticlesListViewModel(closures: ArticlesListViewModelClosures) -> ArticlesListViewModel {
    return DefaultArticlesListViewModel(articlesUseCase: makeFetchArticlesUseCase(), closures: closures)
  }
  
  // MARK: - Articles List
  func makeUsersListViewController(closures: UsersListViewModelClosures) -> UsersListViewController {
    return UsersListViewController.create(with: makeUsersListViewModel(closures: closures))
  }
  
  func makeUsersListViewModel(closures: UsersListViewModelClosures) -> UsersListViewModel {
    return DefaultUsersListViewModel(usersUseCase: makeFetchUsersUseCase())
  }
  
  // MARK: - Flow Coordinators
  func makeArticlesListFlowCoordinator(navigationController: UINavigationController) -> ArticlesListFlowCoordinator {
    return ArticlesListFlowCoordinator(navigationController: navigationController,
                                       dependencies: self)
  }
}

extension ArticlesSceneDIContainer: ArticlesListFlowCoordinatorDependencies {}
