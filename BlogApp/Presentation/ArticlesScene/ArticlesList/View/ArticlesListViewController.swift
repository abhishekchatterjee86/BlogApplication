//
//  ArticlesListViewController.swift
//  BlogApp
//
//  Created by Abhishek on 18/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import UIKit

class ArticlesListViewController: UITableViewController, StoryboardInstantiable, Alertable {
  
  var isLoading = false
  var imagesRepository: ImagesRepository?
  var nextPageLoadingSpinner: UIActivityIndicatorView?
  
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
    
    let usersListBarButtonItem = UIBarButtonItem(title: "Users List", style: .plain, target: self, action: #selector(self.showUsersList));
    self.navigationItem.leftBarButtonItem  = usersListBarButtonItem
    
    let loadMoreBarButtonItem = UIBarButtonItem(title: "Load More", style: .plain, target: self, action: #selector(self.loadMore));
    self.navigationItem.rightBarButtonItem  = loadMoreBarButtonItem
    
    self.viewModel.didFetchArticles()
  }
  
  private func bind(to viewModel: ArticlesListViewModel) {
    viewModel.items.observe(on: self) { [weak self] _ in self?.tableView.reloadData() }
    viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    viewModel.loadingType.observe(on: self) { [weak self] in self?.update(isLoadingNextPage: $0 == .nextPage) }
  }
  
  @objc func showUsersList() {
    viewModel.didShowUsersList()
  }
  
  @objc func loadMore() {
    viewModel.didLoadNextPage()
  }
  
  func update(isLoadingNextPage: Bool) {
    if isLoadingNextPage {
      nextPageLoadingSpinner?.removeFromSuperview()
      nextPageLoadingSpinner = UIActivityIndicatorView(style: .medium)
      nextPageLoadingSpinner?.startAnimating()
      nextPageLoadingSpinner?.isHidden = false
      nextPageLoadingSpinner?.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.frame.width, height: 44)
      tableView.tableFooterView = nextPageLoadingSpinner
    } else {
      tableView.tableFooterView = nil
    }
  }
  
  private func showError(_ error: String) {
    guard !error.isEmpty else { return }
    showAlert(title: viewModel.errorTitle, message: error)
  }
}

extension ArticlesListViewController {
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.items.value.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticlesListTableViewCell.reuseIdentifier, for: indexPath) as? ArticlesListTableViewCell else {
      fatalError("Cannot dequeue reusable cell \(ArticlesListTableViewCell.self) with reuseIdentifier: \(ArticlesListTableViewCell.reuseIdentifier)")
    }
    
    cell.fill(with: viewModel.items.value[indexPath.row],
              imagesRepository: imagesRepository)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      viewModel.didSelectUsersList(at: indexPath.row)
  }
}
