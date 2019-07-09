//
//Copyright (c) 2019 nkopilovskii <nkopilovskii@gmail.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
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
