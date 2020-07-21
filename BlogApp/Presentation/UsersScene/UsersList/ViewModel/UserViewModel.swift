//
//  UserViewModel.swift
//  BlogApp
//
//  Created by Abhishek on 21/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

struct UserViewModel {
  let city: String
  let userName: String
  let userDesignation: String
}

extension UserViewModel {
  init(user: User) {
    self.userName = user.firstName + user.lastName
    self.userDesignation = user.designation
    self.city = user.city
  }
}
