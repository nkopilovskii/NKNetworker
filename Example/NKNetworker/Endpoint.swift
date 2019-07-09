//
//  Endpoint.swift
//  NKNetworker
//
//  Created by Nick Kopilovskii on 1/9/19.
//  Copyright © 2019 Nick Kopilovskii. All rights reserved.
//

import Foundation
import NKNetworker

enum Endpoint: String, NKNEndpoint {
  case users = "users"
  case posts = "posts"
  
  private static var baseURLString = "https://jsonplaceholder.typicode.com/"
  
  var stringValue: String {
    return Endpoint.baseURLString + rawValue
  }
  
  
}

