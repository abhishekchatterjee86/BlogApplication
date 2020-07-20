//
//  Mappable.swift
//  BlogApp
//
//  Created by Abhishek on 19/07/20.
//  Copyright © 2020 Abhishek Chatterjee. All rights reserved.
//

import SwiftyJSON

public protocol Mappable {
  init(json: JSON)
}
