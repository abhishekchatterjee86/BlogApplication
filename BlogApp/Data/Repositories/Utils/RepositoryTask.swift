//
//  RepositoryTask.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

class RepositoryTask: Cancelable {
  var networkTask: NetworkCancellable?
  var isCancelled: Bool = false
  
  func cancel() {
    networkTask?.cancel()
    isCancelled = true
  }
}
