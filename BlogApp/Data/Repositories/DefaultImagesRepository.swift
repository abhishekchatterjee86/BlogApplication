//
//  DefaultImagesRepository.swift
//  BlogApp
//
//  Created by Abhishek on 20/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

final class DefaultImagesRepository {
    
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultImagesRepository: ImagesRepository {
    
    func fetchImage(with imagePath: String,
                    completion: @escaping (Result<Data, Error>) -> Void) -> Cancelable? {
        
        let endpoint = APIEndpoints.getImage(path: imagePath)
        let task = RepositoryTask()
        task.networkTask = dataTransferService.request(with: endpoint) { (result: Result<Data, DataTransferError>) in

            let result = result.mapError { $0 as Error }
            DispatchQueue.main.async { completion(result) }
        }
        return task
    }
}
