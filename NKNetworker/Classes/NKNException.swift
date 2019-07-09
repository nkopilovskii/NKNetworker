//
//  NKNException.swift
//  NKNetworker
//
//  Created by Nick Kopilovskii on 7/9/19.
//

import Foundation

//MARK: - NKNException protocol
public protocol NKNException: Error {
  var exceptionMessage: String? { get }
}
//MARK: -


//MARK: - NKNStaticExecption. Base NKNStaticExecption implementation
public enum NKNStaticExecption: NKNException {
  case emptyResponseData
  
  public var exceptionMessage: String? {
    switch self {
    case .emptyResponseData:
      return "[NKNetworker.NKNStaticException] The response to a request with this HTTP method may not contain (or does not contain) the body."
    }
  }
}
//MARK: -
