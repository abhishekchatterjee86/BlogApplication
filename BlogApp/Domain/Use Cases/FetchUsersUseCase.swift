//
//  FetchUserUseCase.swift
//  BlogApp
//
//  Created by Abhishek on 21/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

protocol FetchUsersUseCase {
  func execute(requestValue: FetchUsersUseCaseRequestValue,
               completion: @escaping (Result<UsersPage, Error>) -> Void) -> Cancelable?
}

final class DefaultFetchUsersUseCase: FetchUsersUseCase {
  
  private let usersListRepository: UsersListRepository
  
  init(usersListRepository: UsersListRepository) {
    
    self.usersListRepository = usersListRepository
  }
  
  func execute(requestValue: FetchUsersUseCaseRequestValue,
               completion: @escaping (Result<UsersPage, Error>) -> Void) -> Cancelable? {
    
    return usersListRepository.fetchUsersList(page: requestValue.page,
                                                completion: { result in completion(result) })
  }
}

struct FetchUsersUseCaseRequestValue {
  let page: Int
}
