//
//  ArticleResponseEntity.swift
//  BlogApp
//
//  Created by Abhishek on 22/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation
import CoreData

extension ArticlesPageResponseEntity {
  func toDTO() -> ArticlesPage {
    return .init(articles: articles?.allObjects.map { ($0 as! ArticleResponseEntity).toDTO() } ?? [])
  }
}

extension ArticleResponseEntity {
  func toDTO() -> Article {
    return Article(id: id!,
                   content: content!,
                   createdAt: createdAt!,
                   comments: Int(comments),
                   likes: Int(likes),
                   media: media.map { $0.toDTO() },
                   user: user.map { $0.toDTO() })
  }
}

extension MediaResponseEntity {
  func toDTO() -> Media {
    return Media(id: id!,
                   blogId: blogId!,
                   createdAt: createdAt!,
                   imagePath: imagePath!,
                   title: title!,
                   mediaUrl: mediaUrl!)
  }
}

extension UserResponseEntity {
  func toDTO() -> User {
    return User(id: id!,
                   blogId: blogId!,
                   createdAt: createdAt!,
                   firstName: firstName!,
                   lastName: lastName!,
                   avatarImagePath: avatarImagePath!,
                   city: city!,
                   designation: designation!,
                   about: about!)
  }
}


extension APIRequestDTO {
  func toEntity(in context: NSManagedObjectContext) -> ArticlesRequestEntity {
    let entity: ArticlesRequestEntity = .init(context: context)
    entity.page = Int64(page)
    return entity
  }
}

extension ArticlesPage {
  func toEntity(in context: NSManagedObjectContext) -> ArticlesPageResponseEntity {
    let entity: ArticlesPageResponseEntity = .init(context: context)
    articles.forEach {
      entity.addToArticles($0.toEntity(in: context))
    }
    return entity
  }
}

extension Article {
  func toEntity(in context: NSManagedObjectContext) -> ArticleResponseEntity {
    let entity: ArticleResponseEntity = .init(context: context)
    entity.id = id
    entity.content = content
    entity.createdAt = createdAt
    entity.comments = Int64(comments)
    entity.likes = Int64(likes)
    entity.user = user?.toEntity(in: context)
    entity.media = media?.toEntity(in: context)
    return entity
  }
}

extension Media {
  func toEntity(in context: NSManagedObjectContext) -> MediaResponseEntity {
    let entity: MediaResponseEntity = .init(context: context)
    entity.id = id
    entity.blogId = blogId
    entity.createdAt = createdAt
    entity.imagePath = imagePath
    entity.title = title
    entity.mediaUrl = mediaUrl
    return entity
  }
}

extension User {
  func toEntity(in context: NSManagedObjectContext) -> UserResponseEntity {
    let entity: UserResponseEntity = .init(context: context)
    entity.id = id
    entity.blogId = blogId
    entity.createdAt = createdAt
    entity.firstName = firstName
    entity.lastName = lastName
    entity.avatarImagePath = avatarImagePath
    entity.city = city
    entity.designation = designation
    entity.about = about
    return entity
  }
}
