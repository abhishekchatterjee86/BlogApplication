//
//  ArticleResponseStorage.swift
//  BlogApp
//
//  Created by Abhishek on 21/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

protocol ArticlesResponseStorage {
    func getResponse(for request: APIRequestDTO, completion: @escaping (Result<ArticlesPage?, CoreDataStorageError>) -> Void)
    func save(response: ArticlesPage, for requestDto: APIRequestDTO)
}
