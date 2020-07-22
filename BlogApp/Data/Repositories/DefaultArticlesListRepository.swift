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
  private let cache: ArticlesResponseStorage
  
  init(dataTransferService: DataTransferService,
       cache: ArticlesResponseStorage) {
    self.dataTransferService = dataTransferService
    self.cache = cache
  }
}

extension DefaultArticlesListRepository: ArticlesListRepository {
  
  func fetchArticlesList(page: Int,
                         cached: @escaping (ArticlesPage) -> Void,
                         completion: @escaping (Result<ArticlesPage, Error>) -> Void) -> Cancelable? {
    
    let requestDTO = APIRequestDTO(page: page)
    let task = RepositoryTask()
    
    cache.getResponse(for: requestDTO) { result in
      
      if case let .success(response?) = result {
        cached(response)
      }
      guard !task.isCancelled else { return }
      
      let endpoint = APIEndpoints.getArticles(with: requestDTO)
      task.networkTask = self.dataTransferService.request(with: endpoint) { result in
        switch result {
        case .success(let articlesPage):
          self.cache.save(response: articlesPage, for: requestDTO)
          completion(.success(articlesPage))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
    
    return task
  }
}
