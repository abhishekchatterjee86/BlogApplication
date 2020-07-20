//
//  ArticlesListViewModel.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import UIKit

struct ArticlesListViewModelClosures {
  let showUsersList: () -> (Void)
}

protocol ArticlesListViewModelInput {
  func didFetchArticles(page: Int)
}

protocol ArticlesListViewModelOutput {
  var items: Observable<[ArticleViewModel]> { get }
  var page: Observable<Int> { get }
  var error: Observable<String> { get }
  var isEmpty: Bool { get }
  var screenTitle: String { get }
  var errorTitle: String { get }
}

protocol ArticlesListViewModel: ArticlesListViewModelInput, ArticlesListViewModelOutput {}

final class DefaultArticlesListViewModel: ArticlesListViewModel {
  
  private let articlesUseCase: FetchArticlesUseCase
  private let closures: ArticlesListViewModelClosures?
  
  private var articlesLoadTask: Cancelable? { willSet { articlesLoadTask?.cancel() } }
  
  // MARK: - OUTPUT
  
  let items: Observable<[ArticleViewModel]> = Observable([])
  let page: Observable<Int> = Observable(1)
  let error: Observable<String> = Observable("")
  var isEmpty: Bool { return items.value.isEmpty }
  let screenTitle = NSLocalizedString("Articles", comment: "")
  let errorTitle = NSLocalizedString("Error", comment: "")
  
  // MARK: - Init
  
  init(articlesUseCase: FetchArticlesUseCase,
       closures: ArticlesListViewModelClosures? = nil) {
    self.articlesUseCase = articlesUseCase
    self.closures = closures
  }
  
  // MARK: - Private
  
  private func appendArticle(_ page: ArticlesPage) {
    items.value = page.articles.map(ArticleViewModel.init)
  }
  
  private func load(page: Int) {
    self.page.value = page
    
    articlesLoadTask = articlesUseCase.execute(
      requestValue: .init(page: page),
      completion: { result in
        switch result {
        case .success(let pages):
          self.appendArticle(pages)
        case .failure(let error):
          self.handle(error: error)
        }
    })
  }
  
  private func handle(error: Error) {
    self.error.value = error.isInternetConnectionError ?
      NSLocalizedString("No internet connection", comment: "") :
      NSLocalizedString("Failed fetching article details", comment: "")
  }
}

extension DefaultArticlesListViewModel {
  func didFetchArticles(page: Int) {
    load(page: page)
  }
}
