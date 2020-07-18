//
//  ArticlesListViewModel.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import UIKit

struct ArticlesListViewModelClosures {
  let showUsersList: () -> (Void)
}

protocol ArticlesListViewModelInput {

}

protocol ArticlesListViewModelOutput {

}

protocol ArticlesListViewModel: ArticlesListViewModelInput, ArticlesListViewModelOutput {}

final class DefaultArticlesListViewModel: ArticlesListViewModel {
}
