//
//  ArticleViewModel.swift
//  BlogApp
//
//  Created by Abhishek on 19/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

struct ArticleViewModel {
  let userAvatarPath: String?
  let userName: String
  let createdDate: String
  let userDesignation: String
  let articleImagePath: String?
  let articleContent: String
  let articleTitle: String?
  let articleUrl: String?
  let comments: String
  let likes: String
}

extension ArticleViewModel {
  init(article: Article) {
    self.userAvatarPath = article.user.avatarImagePath
    self.userName = article.user.firstName + article.user.lastName
    self.createdDate = article.createdAt.offsetFrom()
    self.userDesignation = article.user.designation
    self.articleImagePath = article.media?.imagePath
    self.articleContent = article.content
    self.articleTitle = article.media?.title
    self.articleUrl = article.media?.mediaUrl
    self.comments = String(article.comments.roundedWithAbbreviations)
    self.likes = String(article.likes.roundedWithAbbreviations)
  }
}
