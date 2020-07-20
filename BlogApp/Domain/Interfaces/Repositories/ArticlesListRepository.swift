//
//  ArticlesListRepository.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

protocol ArticlesListRepository {
  @discardableResult
  func fetchArticlesList(page: Int,
                         completion: @escaping (Result<ArticlesPage, Error>) -> Void) -> Cancelable?
}
