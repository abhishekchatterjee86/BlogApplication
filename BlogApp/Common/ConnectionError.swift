//
//  ConnectionError.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

public protocol ConnectionError: Error {
  var isInternetConnectionError: Bool { get }
}

public extension Error {
  var isInternetConnectionError: Bool {
    guard let error = self as? ConnectionError, error.isInternetConnectionError else {
      return false
    }
    return true
  }
}
