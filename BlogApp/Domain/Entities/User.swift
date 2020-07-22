//
//  User.swift
//  BlogApp
//
//  Created by Abhishek on 21/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
  let id: String
  let blogId: String
  let createdAt: Date
  let firstName: String
  let lastName: String
  let avatarImagePath: String?
  let city: String
  let designation: String
  let about: String
}

extension User: Mappable {
  init(json: JSON) {
    id = json["id"].stringValue
    blogId = json["blogId"].stringValue
    createdAt = json["createdAt"].stringValue.toDate() ?? Date()
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

struct UsersPage: Mappable {
  let users: [User]

  init(json: JSON) {
    users = json.arrayValue.map({ User.init(json: $0) })
  }
}
