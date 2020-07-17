//
//  APIEndPoints.swift
//  BlogApp
//
//  Created by Abhishek on 17/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

struct APIEndpoints {
  
  static func getArticles(with articlesRequestDTO: APIRequestDTO) -> Endpoint<ArticleResponseDTO> {
    
    return Endpoint(path: "jet2/api/v1/blogs/",
                    method: .get,
                    queryParametersEncodable: articlesRequestDTO)
  }
  
  static func getUsers(with usersRequestDTO: APIRequestDTO) -> Endpoint<UserResponseDTO> {
    
    return Endpoint(path: "jet2/api/v1/users/",
                    method: .get,
                    queryParametersEncodable: usersRequestDTO)
  }
}
