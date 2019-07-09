//
//  NKNError.swift
//  NKNetworker
//
//  Created by Nick Kopilovskii on 7/9/19.
//

import Foundation

//MARK: - NKNError protocol
public protocol NKNError: Error {
  var errorMessage: String? { get }
}
//MARK: -


//MARK: - NKNStaticError. Base NKNError implementation
public enum NKNStaticError: Error, NKNError {
  case unknown
  case invalidURL
  case invalidRequest
  case noInternetConnection
  case undecoded
  case emptyResponseData
  
  public var errorMessage: String? {
    switch self {
    case .unknown: return "[NKNetworker.NKNStaticError] Unknown Error"
    case .invalidURL: return "[NKNetworker.NKNStaticError] Invalid URL"
    case .invalidRequest: return "[NKNetworker.NKNStaticError] Invalid HTTP Request"
    case .noInternetConnection: return "[NKNetworker.NKNStaticError] No Internet Connection"
    case .undecoded: return "[NKNetworker.NKNStaticError] Data received in the response can not be decoded to the entity of current type."
    case .emptyResponseData: return "[NKNetworker.NKNStaticError] Response contains no data"
    }
  }
}
//MARK: -
