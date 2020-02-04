//
//  Parameters.swift
//  NKNetworker_Example
//
//  Created by Nick Kopilovskii on 7/9/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import NKNetworker

struct PathParameter: NKNPathParameter {
  var key: String?
  var value: String?

  init( key: String?, value: String?) {
    self.key = key
    self.value = value
  }
}


enum QueryParameter: NKNQueryParameter {
  case userId(Int)
  
  var key: String? {
    switch self {
    case .userId: return "userId"
    }
  }
  
  var value: String? {
    switch self {
    case .userId(let value): return "\(value)"
    }
  }
}


//MARK: - NKNRequestFetcher extension


extension NKNRequestFetcher {
  struct ConnectionError: NKNError {
    var errorMessage: String? {
      return "Interner connection was lost"
    }
  }
  
  static var defaultErrorHandler: NKNResponseErrorHandler {
    return { data, response, error -> Error? in
      //Custom handler on static error
      guard let staticError = error as? NKNStaticError else {
        return nil
      }
      
      switch staticError {
      case .noInternetConnection:
        return ConnectionError()
      default:
        return nil
      }
      
    }
  }
}
