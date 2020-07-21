//
//  UsersListRepository.swift
//  BlogApp
//
//  Created by Abhishek on 21/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

protocol UsersListRepository {
  @discardableResult
  func fetchUsersList(page: Int,
                         completion: @escaping (Result<UsersPage, Error>) -> Void) -> Cancelable?
}
