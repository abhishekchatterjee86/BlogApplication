//
//  UserDetailsViewModel.swift
//  BlogApp
//
//  Created by Abhishek on 21/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

protocol UserDetailsViewModelInput {
  func updateAvatarImage()
}

protocol UserDetailsViewModelOutput {
  var userName: String { get }
  var userDesignation: String { get }
  var city: String { get }
  var avatarImage: Observable<Data?> { get }
  var isAvatarImageHidden: Bool { get }
  var userDescription: String { get }
}

protocol UserDetailsViewModel: UserDetailsViewModelInput, UserDetailsViewModelOutput { }

final class DefaultUserDetailsViewModel: UserDetailsViewModel {  
  private let avatarImagePath: String?
  private let imagesRepository: ImagesRepository
  private var imageLoadTask: Cancelable? { willSet { imageLoadTask?.cancel() } }
  
  // MARK: - OUTPUT
  let userName: String
  let userDesignation: String
  let city: String
  let userDescription: String
  let avatarImage: Observable<Data?> = Observable(nil)
  let isAvatarImageHidden: Bool
  
  init(user: User,
       imagesRepository: ImagesRepository) {
    self.userName = user.firstName + user.lastName
    self.userDesignation = user.designation
    self.city = user.city
    self.avatarImagePath = user.avatarImagePath
    self.isAvatarImageHidden = user.avatarImagePath == nil
    self.userDescription = user.about
    self.imagesRepository = imagesRepository
  }
}

// MARK: - INPUT. View event methods
extension DefaultUserDetailsViewModel {
  
  func updateAvatarImage() {
    guard let imagePath = avatarImagePath else { return }
    
    imageLoadTask = imagesRepository.fetchImage(with: imagePath) { result in
      guard self.avatarImagePath == imagePath else { return }
      switch result {
      case .success(let data):
        self.avatarImage.value = data
      case .failure: break
      }
      self.imageLoadTask = nil
    }
  }
}
