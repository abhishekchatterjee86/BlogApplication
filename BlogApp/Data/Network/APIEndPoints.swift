//
//  APIEndPoints.swift
//  BlogApp
//
//  Created by Abhishek on 17/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

struct APIEndpoints {
  
  static func getArticles(with articlesRequestDTO: APIRequestDTO) -> Endpoint<ArticlesPage> {
    
    return Endpoint(path: "jet2/api/v1/blogs/",
                    method: .get,
                    queryParametersEncodable: articlesRequestDTO)
  }
  
  static func getUsers(with usersRequestDTO: APIRequestDTO) -> Endpoint<User> {
    
    return Endpoint(path: "jet2/api/v1/users/",
                    method: .get,
                    queryParametersEncodable: usersRequestDTO)
  }
  
  static func getImage(path: String) -> Endpoint<Data> {
    
      return Endpoint(path: path,
                      method: .get,
                      responseDecoder: RawDataResponseDecoder())
  }
}
