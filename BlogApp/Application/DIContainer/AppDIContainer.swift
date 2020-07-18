//
//  AppDIContainer.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

final class AppDIContainer {
  
  lazy var appConfiguration = AppConfiguration()
  
  // MARK: - Network
  lazy var apiDataTransferService: DataTransferService = {
    let config = ApiDataNetworkConfig(baseURL: URL(string: appConfiguration.apiBaseURL)!)
    
    let apiDataNetwork = DefaultNetworkService(config: config)
    return DefaultDataTransferService(with: apiDataNetwork)
  }()
  
  // MARK: - DIContainers of scenes
  func makeArticlesSceneDIContainer() -> ArticlesSceneDIContainer {
    let dependencies = ArticlesSceneDIContainer.Dependencies(apiDataTransferService: apiDataTransferService)
    return ArticlesSceneDIContainer(dependencies: dependencies)
  }
}

