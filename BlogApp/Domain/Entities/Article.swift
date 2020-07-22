//
//  Article.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Article {
  let id: String
  let content: String
  let createdAt: Date
  let comments: Int
  let likes: Int
  let media: Media?
  let user: User?
}

extension Article: Mappable {
  init(json: JSON) {
    id = json["id"].stringValue
    content = json["content"].stringValue
    createdAt = json["createdAt"].stringValue.toDate() ?? Date()
    comments = json["comments"].intValue
    likes = json["likes"].intValue
    media = json["media"].array?.first.map({ Media(json: $0) })
    user = (json["user"].array?.first.map({ User(json: $0) }))
  }
}

struct Media {
  let id: String
  let blogId: String
  let createdAt: Date
  let imagePath: String
  let title: String
  let mediaUrl: String
}

extension Media: Mappable {
  init(json: JSON) {
    id = json["id"].stringValue
    blogId = json["blogId"].stringValue
    createdAt = json["createdAt"].stringValue.toDate() ?? Date()
    title = json["title"].stringValue
    mediaUrl = json["url"].stringValue
    imagePath = json["image"]
      .stringValue
      .replacingOccurrences(of: "https://s3.amazonaws.com/uifaces/faces/twitter/", with: "")
  }
}

struct ArticlesPage{
  let articles: [Article]
}

extension ArticlesPage: Mappable  {
  init(json: JSON) {
    articles = json.arrayValue.map({ Article.init(json: $0) })
  }
}

extension Data: Mappable {
  public init(json: JSON) { self =  Data.init() }
}

