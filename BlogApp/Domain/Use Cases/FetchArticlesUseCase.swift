//
//  FetchArticlesUseCase.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

protocol FetchArticlesUseCase {
  func execute(requestValue: FetchArticlesUseCaseRequestValue,
               completion: @escaping (Result<ArticlesPage, Error>) -> Void) -> Cancelable?
}

final class DefaultFetchArticlesUseCase: FetchArticlesUseCase {
  
  private let articlesRepository: ArticlesListRepository
  
  init(articlesRepository: ArticlesListRepository) {
    
    self.articlesRepository = articlesRepository
  }
  
  func execute(requestValue: FetchArticlesUseCaseRequestValue,
               completion: @escaping (Result<ArticlesPage, Error>) -> Void) -> Cancelable? {
    
    return articlesRepository.fetchArticlesList(page: requestValue.page,
                                                completion: { result in completion(result) })
  }
}

struct FetchArticlesUseCaseRequestValue {
  let page: Int
}
