//
//  DefaultArticlesListRepository.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

final class DefaultArticlesListRepository {
  
  private let dataTransferService: DataTransferService
  
  init(dataTransferService: DataTransferService) {
    self.dataTransferService = dataTransferService
  }
}

extension DefaultArticlesListRepository: ArticlesListRepository {
  
  func fetchArticlesList(page: Int,
                         completion: @escaping (Result<ArticlesPage, Error>) -> Void) -> Cancelable? {
    
    let requestDTO = APIRequestDTO(page: page)
    let task = RepositoryTask()
    
    guard !task.isCancelled else { return task }
    
    let endpoint = APIEndpoints.getArticles(with: requestDTO)
    task.networkTask = self.dataTransferService.request(with: endpoint) { result in
      switch result {
      case .success(let articlesPage):
        completion(.success(articlesPage))
      case .failure(let error):
        completion(.failure(error))
      }
    }
    return task
  }
}
