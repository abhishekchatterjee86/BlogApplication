//
//  ArticlesListViewController.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import UIKit

class ArticlesListViewController: UITableViewController, StoryboardInstantiable, Alertable {
  
  var imagesRepository: ImagesRepository?

  private var viewModel: ArticlesListViewModel!
  
  // MARK: - Lifecycle
  
  static func create(with viewModel: ArticlesListViewModel,
                     imagesRepository: ImagesRepository) -> ArticlesListViewController {
    let view = ArticlesListViewController.instantiateViewController()
    view.viewModel = viewModel
    view.imagesRepository = imagesRepository
    return view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = viewModel.screenTitle
    bind(to: viewModel)
    
    self.viewModel.didFetchArticles(page: 1)
  }
  
  private func bind(to viewModel: ArticlesListViewModel) {
    viewModel.items.observe(on: self) { [weak self] _ in self?.tableView.reloadData() }
    viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
  }
  
  private func showError(_ error: String) {
      guard !error.isEmpty else { return }
      showAlert(title: viewModel.errorTitle, message: error)
  }
  
  // MARK: - Table view data source

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.items.value.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticlesListTableViewCell.reuseIdentifier, for: indexPath) as? ArticlesListTableViewCell else {
          fatalError("Cannot dequeue reusable cell \(ArticlesListTableViewCell.self) with reuseIdentifier: \(ArticlesListTableViewCell.reuseIdentifier)")
      }

    cell.fill(with: viewModel.items.value[indexPath.row], imagesRepository: imagesRepository)

      return cell
  }
}
