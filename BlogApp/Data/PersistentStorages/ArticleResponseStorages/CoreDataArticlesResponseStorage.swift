//
//  CoreDataArticleResponseStorage.swift
//  BlogApp
//
//  Created by Abhishek on 21/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataArticlesResponseStorage {
  
  private let coreDataStorage: CoreDataStorage
  
  init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
    self.coreDataStorage = coreDataStorage
  }
  
  // MARK: - Private
  
  private func fetchRequest(for requestDto: APIRequestDTO) -> NSFetchRequest<ArticlesRequestEntity> {
    let request: NSFetchRequest = ArticlesRequestEntity.fetchRequest()
    request.predicate = NSPredicate(format: "%K = %d",
      #keyPath(ArticlesRequestEntity.page), requestDto.page)
    return request
  }
  
  private func deleteResponse(for requestDto: APIRequestDTO, in context: NSManagedObjectContext) {
    let request = fetchRequest(for: requestDto)
    
    do {
      if let result = try context.fetch(request).first {
        context.delete(result)
      }
    } catch {
      print(error)
    }
  }
}

extension CoreDataArticlesResponseStorage: ArticlesResponseStorage {
  
  func getResponse(for requestDto: APIRequestDTO, completion: @escaping (Result<ArticlesPage?, CoreDataStorageError>) -> Void) {
    coreDataStorage.performBackgroundTask { context in
      do {
        let fetchRequest = self.fetchRequest(for: requestDto)
        let requestEntity = try context.fetch(fetchRequest).first
        
        completion(.success(requestEntity?.response?.toDTO()))
      } catch {
        completion(.failure(CoreDataStorageError.readError(error)))
      }
    }
  }
  
  func save(response responseDto: ArticlesPage, for requestDto: APIRequestDTO) {
    coreDataStorage.performBackgroundTask { context in
      do {
        self.deleteResponse(for: requestDto, in: context)
        
        let requestEntity = requestDto.toEntity(in: context)
        requestEntity.response = responseDto.toEntity(in: context)
        
        try context.save()
      } catch {
        // TODO: - Log to Crashlytics
        debugPrint("CoreDataArticlesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
      }
    }
  }
}
