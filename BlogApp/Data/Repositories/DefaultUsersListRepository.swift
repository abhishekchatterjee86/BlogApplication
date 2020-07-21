//
//  DefaultUsersListRepository.swift
//  BlogApp
//
//  Created by Abhishek on 21/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

final class DefaultUsersListRepository {
  
  private let dataTransferService: DataTransferService
  
  init(dataTransferService: DataTransferService) {
    self.dataTransferService = dataTransferService
  }
}

extension DefaultUsersListRepository: UsersListRepository {
 
  func fetchUsersList(page: Int,
                         completion: @escaping (Result<UsersPage, Error>) -> Void) -> Cancelable? {
    
    let requestDTO = APIRequestDTO(page: page)
    let task = RepositoryTask()
    
    guard !task.isCancelled else { return task }
    
    let endpoint = APIEndpoints.getUsers(with: requestDTO)
    task.networkTask = self.dataTransferService.request(with: endpoint) { result in
      switch result {
      case .success(let usersPage):
        completion(.success(usersPage))
      case .failure(let error):
        completion(.failure(error))
      }
    }
    return task
  }
}
