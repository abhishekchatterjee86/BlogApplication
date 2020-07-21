//
//  UsersListViewModel.swift
//  BlogApp
//
//  Created by Abhishek on 21/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

struct UsersListViewModelClosures {
}

enum UsersListViewModelLoading {
    case fullScreen
    case nextPage
}

protocol UsersListViewModelInput {
  func didLoadNextPage()
  func didFetchUsersList()
}

protocol UsersListViewModelOutput {
  var items: Observable<[UserViewModel]> { get }
  var loadingType: Observable<UsersListViewModelLoading?> { get }
  var error: Observable<String> { get }
  var isEmpty: Bool { get }
  var screenTitle: String { get }
  var errorTitle: String { get }
}

protocol UsersListViewModel: UsersListViewModelInput, UsersListViewModelOutput {}

final class DefaultUsersListViewModel: UsersListViewModel {
  
  var currentPage: Int = 0
  var nextPage: Int { currentPage + 1 }
  
  private let usersUseCase: FetchUsersUseCase
  private let closures: UsersListViewModelClosures?
  
  private var usersLoadTask: Cancelable? { willSet { usersLoadTask?.cancel() } }
  
  // MARK: - OUTPUT
  
  let items: Observable<[UserViewModel]> = Observable([])
  let loadingType: Observable<UsersListViewModelLoading?> = Observable(.none)
  let error: Observable<String> = Observable("")
  var isEmpty: Bool { return items.value.isEmpty }
  let screenTitle = NSLocalizedString("Users", comment: "")
  let errorTitle = NSLocalizedString("Error", comment: "")
  
  // MARK: - Init
  
  init(usersUseCase: FetchUsersUseCase,
       closures: UsersListViewModelClosures? = nil) {
    self.usersUseCase = usersUseCase
    self.closures = closures
  }
  
  // MARK: - Private
  
  private func appendArticle(_ page: UsersPage) {
    currentPage = currentPage + 1
    if page.users.count == 0 {
      currentPage = 0
    } else {
      items.value = page.users.map(UserViewModel.init)
    }
  }
  
  private func load(loadingType: UsersListViewModelLoading) {
    self.loadingType.value = loadingType
    
    usersLoadTask = usersUseCase.execute(
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

extension DefaultUsersListViewModel {
  func didLoadNextPage() {
      guard loadingType.value == .none else { return }
      load(loadingType: .nextPage)
  }
  
  func didFetchUsersList() {
    load(loadingType: .fullScreen)
  }
}
