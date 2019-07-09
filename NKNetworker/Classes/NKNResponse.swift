//
//  NKNResponse.swift
//  NKNetworker
//
//  Created by Nick Kopilovskii on 7/9/19.
//

import Foundation

//MARK: - NKNResponse
public enum NKNResponse<ResponseType> {
  case success(ResponseType)
  case failure(Error)
  case exception(NKNException)
  
  @discardableResult
  func dematerialize() throws -> ResponseType {
    switch self {
    case let .success(value): return value
    case let .failure(error): throw error
    case let .exception(exeption): throw exeption
    }
  }
}
//MARK: -
