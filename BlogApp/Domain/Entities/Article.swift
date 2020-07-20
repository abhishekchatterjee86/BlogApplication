//
//  Article.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Article: Mappable {
  let id: String
  let content: String
//  let createdAt: Date
  let comments: Int
  let likes: Int
  let media: Media?
  let user: User
  
  init(json: JSON) {
    id = json["id"].stringValue
    content = json["content"].stringValue
//    createdAt = json["createdAt"].
    comments = json["comments"].intValue
    likes = json["likes"].intValue
    media = json["media"].array?.first.map({ Media(json: $0) })
    user = (json["user"].array?.first.map({ User(json: $0) }))!
  }
}

struct Media: Mappable {
  let id: String
  let blogId: String
//  let createdAt: Date
  let imagePath: String
  let title: String
  let mediaUrl: String
  
  init(json: JSON) {
    id = json["id"].stringValue
    blogId = json["blogId"].stringValue
    title = json["title"].stringValue
    mediaUrl = json["url"].stringValue
    imagePath = json["image"]
      .stringValue
      .replacingOccurrences(of: "https://s3.amazonaws.com/uifaces/faces/twitter/", with: "")
  }
}

struct User: Mappable {
  let id: String
  let blogId: String
//  let createdAt: Date
  let firstName: String
  let lastName: String
  let avatarImagePath: String?
  let city: String
  let designation: String
  let about: String
  
  init(json: JSON) {
    id = json["id"].stringValue
    blogId = json["blogId"].stringValue
    firstName = json["name"].stringValue
    lastName = json["lastname"].stringValue
    city = json["city"].stringValue
    designation = json["designation"].stringValue
    about = json["about"].stringValue
    avatarImagePath = json["avatar"]
      .stringValue
      .replacingOccurrences(of: "https://s3.amazonaws.com/uifaces/faces/twitter/", with: "")
  }
}

struct ArticlesPage: Mappable {
  let articles: [Article]

  init(json: JSON) {
    articles = json.arrayValue.map({ Article.init(json: $0) })
  }
}

extension Data: Mappable {
  public init(json: JSON) { self =  Data.init() }
}
