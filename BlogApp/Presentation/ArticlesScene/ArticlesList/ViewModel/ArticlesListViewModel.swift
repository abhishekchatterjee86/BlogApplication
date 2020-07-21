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

enum ArticleListViewModelLoading {
    case fullScreen
    case nextPage
}

protocol ArticlesListViewModelInput {
  func didLoadNextPage()
  func didFetchArticles()
}

protocol ArticlesListViewModelOutput {
  var items: Observable<[ArticleViewModel]> { get }
  var loadingType: Observable<ArticleListViewModelLoading?> { get }
  var error: Observable<String> { get }
  var isEmpty: Bool { get }
  var screenTitle: String { get }
  var errorTitle: String { get }
}

protocol ArticlesListViewModel: ArticlesListViewModelInput, ArticlesListViewModelOutput {}

final class DefaultArticlesListViewModel: ArticlesListViewModel {
  
  var currentPage: Int = 0
  var nextPage: Int { currentPage + 1 }
  
  private let articlesUseCase: FetchArticlesUseCase
  private let closures: ArticlesListViewModelClosures?
  
  private var articlesLoadTask: Cancelable? { willSet { articlesLoadTask?.cancel() } }
  
  // MARK: - OUTPUT
  
  let items: Observable<[ArticleViewModel]> = Observable([])
  let loadingType: Observable<ArticleListViewModelLoading?> = Observable(.none)
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
    currentPage = currentPage + 1
    if page.articles.count == 0 {
      currentPage = 0
    } else {
      items.value = page.articles.map(ArticleViewModel.init)
    }
  }
  
  private func load(loadingType: ArticleListViewModelLoading) {
    self.loadingType.value = loadingType
    
    articlesLoadTask = articlesUseCase.execute(
      requestValue: .init(page: nextPage),
      completion: { result in
        switch result {
        case .success(let pages):
          self.appendArticle(pages)
        case .failure(let error):
          self.handle(error: error)
        }
        self.loadingType.value = .none
    })
  }
  
  private func resetPages() {
      currentPage = 0
      items.value.removeAll()
  }
  
  private func update() {
      resetPages()
      load(loadingType: .fullScreen)
  }
  
  private func handle(error: Error) {
    self.error.value = error.isInternetConnectionError ?
      NSLocalizedString("No internet connection", comment: "") :
      NSLocalizedString("Failed fetching article details", comment: "")
  }
}

extension DefaultArticlesListViewModel {
  func didLoadNextPage() {
      guard loadingType.value == .none else { return }
      load(loadingType: .nextPage)
  }
  
  func didFetchArticles() {
    load(loadingType: .fullScreen)
  }
}
