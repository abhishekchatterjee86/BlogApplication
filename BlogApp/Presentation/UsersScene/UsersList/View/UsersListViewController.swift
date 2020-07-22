//
//  UsersListViewController.swift
//  BlogApp
//
//  Created by Abhishek on 21/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import UIKit

class UsersListViewController: UITableViewController, StoryboardInstantiable, Alertable {
  
  var isLoading = false
  var nextPageLoadingSpinner: UIActivityIndicatorView?
  
  private var viewModel: UsersListViewModel!
  
  // MARK: - Lifecycle
  
  static func create(with viewModel: UsersListViewModel) -> UsersListViewController {
    let view = UsersListViewController.instantiateViewController()
    view.viewModel = viewModel
    return view
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = viewModel.screenTitle
    bind(to: viewModel)
    
    let loadMoreBarButtonItem = UIBarButtonItem(title: "Load More", style: .plain, target: self, action: #selector(self.loadMore));
    self.navigationItem.rightBarButtonItem  = loadMoreBarButtonItem
    
    self.viewModel.didFetchUsersList()
  }
  
  private func bind(to viewModel: UsersListViewModel) {
    viewModel.items.observe(on: self) { [weak self] _ in self?.tableView.reloadData() }
    viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    viewModel.loadingType.observe(on: self) { [weak self] in self?.update(isLoadingNextPage: $0 == .nextPage) }
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

extension UsersListViewController {
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.items.value.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersListTableViewCell.reuseIdentifier, for: indexPath) as? UsersListTableViewCell else {
      fatalError("Cannot dequeue reusable cell \(UsersListTableViewCell.self) with reuseIdentifier: \(UsersListTableViewCell.reuseIdentifier)")
    }
    
    cell.fill(with: viewModel.items.value[indexPath.row])
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      viewModel.didSelectUsersList(at: indexPath.row)
  }
}
