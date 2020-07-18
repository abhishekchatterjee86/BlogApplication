//
//  ViewController.swift
//  BlogApp
//
//  Created by Abhishek on 17/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

public protocol NetworkConfigurable {
  var baseURL: URL { get }
  var headers: [String: String] { get }
  var queryParameters: [String: String] { get }
}

public struct ApiDataNetworkConfig: NetworkConfigurable {
  public let baseURL: URL
  public let headers: [String: String]
  public let queryParameters: [String: String]
  
  public init(baseURL: URL,
              headers: [String: String] = [:],
              queryParameters: [String: String] = [:]) {
    self.baseURL = baseURL
    self.headers = headers
    self.queryParameters = queryParameters
  }
}