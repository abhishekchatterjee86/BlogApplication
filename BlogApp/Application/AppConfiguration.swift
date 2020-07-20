//
//  AppConfiguration.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

final class AppConfiguration {
  lazy var apiBaseURL: String = {
    guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
      fatalError("ApiBaseURL must not be empty in plist")
    }
    return apiBaseURL
  }()
  
  lazy var imageBaseURL: String = {
    guard let imageURL = Bundle.main.object(forInfoDictionaryKey: "ImageBaseURL") as? String else {
      fatalError("ImageBaseURL must not be empty in plist")
    }
    return imageURL
  }()
  
  lazy var limit: String = {
    guard let limitValue = Bundle.main.object(forInfoDictionaryKey: "Limit") as? String else {
      fatalError("Limit must not be empty in plist")
    }
    return limitValue
  }()
}

