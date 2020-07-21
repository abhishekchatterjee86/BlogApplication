//
//  String.swift
//  BlogApp
//
//  Created by Abhishek on 19/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import Foundation

extension String {
  func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = format
    let date = dateFormatter.date(from: self)
    
    return date
  }
}

