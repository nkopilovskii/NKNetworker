//
//  NKNEndpoint.swift
//  NKNetworker
//
//  Created by Nick Kopilovskii on 7/9/19.
//

import Foundation

//MARK: - NKNEndpoint public protocol
public protocol NKNEndpoint {
  var stringValue: String { get }
}
//MARK: -

//MARK: - NKNEndpoint default extension
public extension NKNEndpoint {
  func url(with pathParameters: NKNPathParameters? = nil, queryParameters: NKNQueryParameters? = nil) -> URL? {
    var urlString = stringValue
    
    if let pathParameters = pathParameters {
      urlString.append("/")
      pathParameters.forEach {
        guard let value = $0.value else { return }
        guard let key = $0.key, let range = urlString.range(of: key) else {
          urlString.append(value)
          return
        }
        urlString = urlString.replacingCharacters(in: range, with: value)
      }
    }
    
    if let queryParameters = queryParameters {
      var query = String()
      queryParameters.forEach {
        query.append(query.isEmpty ? "?" : "&")
        query.append($0.stringValue ?? "")
      }
      urlString.append(query)
    }
    
    return URL(string: urlString)
  }
}
//MARK: -
