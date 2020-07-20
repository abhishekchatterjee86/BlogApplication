//
//  TableCellImageRepository.swift
//  BlogApp
//
//  Created by Abhishek on 20/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

protocol ImagesRepository {
    func fetchImage(with imagePath: String,
                    completion: @escaping (Result<Data, Error>) -> Void) -> Cancelable?
}
