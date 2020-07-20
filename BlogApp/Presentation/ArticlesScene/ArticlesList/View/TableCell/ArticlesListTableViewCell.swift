//
//  ArticlesListTableViewCell.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import UIKit

class ArticlesListTableViewCell: UITableViewCell {
  
  static let reuseIdentifier = String(describing: ArticlesListTableViewCell.self)
  
  @IBOutlet private var avatarImageView: UIImageView!
  @IBOutlet private var userNameLabel: UILabel!
  @IBOutlet private var userDesignationLabel: UILabel!
  @IBOutlet private var articleImageView: UIImageView!
  @IBOutlet private var articleContentLabel: UILabel!
  @IBOutlet private var articleTitleLabel: UILabel!
  @IBOutlet private var articleUrlLabel: UILabel!
  @IBOutlet private var likesLabel: UILabel!
  @IBOutlet private var commentsLabel: UILabel!
  
  private var viewModel: ArticleViewModel!
  private var imagesRepository: ImagesRepository?
  private var imageLoadTask: Cancelable?
  
  override func layoutSubviews() {
    avatarImageView.layer.cornerRadius = 28.0
  }
  
  func fill(with viewModel: ArticleViewModel, imagesRepository: ImagesRepository?) {
    self.viewModel = viewModel
    self.imagesRepository = imagesRepository
    
    userNameLabel.text = viewModel.userName
    userDesignationLabel.text = viewModel.userDesignation
    articleContentLabel.text = viewModel.articleContent
    articleTitleLabel.text = viewModel.articleTitle
    articleUrlLabel.text = viewModel.articleUrl
    likesLabel.text = viewModel.likes
    commentsLabel.text = viewModel.comments
    updateImages()
  }
  
  private func updateImages() {
    avatarImageView.image = nil
    guard let avatarPath = viewModel.userAvatarPath else { return }
    
    imageLoadTask = imagesRepository?.fetchImage(with: avatarPath) { [weak self] result in
      guard let self = self else { return }
      guard self.viewModel.userAvatarPath == avatarPath else { return }
      if case let .success(data) = result {
        self.avatarImageView.image = UIImage(data: data)
      }
      self.imageLoadTask = nil
    }
    
    articleImageView.image = nil
    guard let imagePath = viewModel.articleImagePath else { return }
    
    imageLoadTask = imagesRepository?.fetchImage(with: imagePath) { [weak self] result in
      guard let self = self else { return }
      guard self.viewModel.articleImagePath == imagePath else { return }
      if case let .success(data) = result {
        self.articleImageView.image = UIImage(data: data)
      }
    }
  }
  
}
