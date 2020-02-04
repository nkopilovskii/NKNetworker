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
//  NKNRequestFetcher.swift
//  NKNetworker
//
//  Created by Nick Kopilovskii on 7/9/19.
//

import Foundation

//MARK: - NKNRequestFetcher Closures Types
public extension NKNRequestFetcher {
  typealias NKNRequestCompletion = (NKNResponse<Data>) -> ()
  typealias NKNResponseErrorHandler = (Data?, URLResponse?, Error?) -> Error?
  typealias NKNResponseExeptionHandler = (Data?, URLResponse?, Error?) -> NKNException?
}
//MARK: -

//MARK: - NKNRequestFetcher base generic
open class NKNRequestFetcher<RequestT: Encodable> {
  
  //MARK: Base properties
  open var endpoint: NKNEndpoint
  open var header: NKNHeaderParameters?
  open var path: NKNPathParameters?
  open var query: NKNQueryParameters?
  
  open var errorHandler: NKNResponseErrorHandler?
  open var exceptionHandler: NKNResponseExeptionHandler?
  
  //MARK: Log properties
  open var printLogRequest = false
  open var logRequestEncodingFormat = String.Encoding.utf8
  
  open var printLogResponse = false
  open var logResponseEncodingFormat = String.Encoding.utf8
  
  required public init(_ endpoint: NKNEndpoint, header: NKNHeaderParameters? = nil, path: NKNPathParameters? = nil, query: NKNQueryParameters? = nil, errorHandler: NKNResponseErrorHandler? = nil, exeptionHandler: NKNResponseExeptionHandler? = nil) {
    self.endpoint = endpoint
    self.header = header
    self.path = path
    self.query = query
    self.errorHandler = errorHandler
    self.exceptionHandler = exeptionHandler
  }
}

//MARK: - NKNRequestFetcher request methods
public extension NKNRequestFetcher {
  enum HTTPMethod: String {
    case CONNECT
    case DELETE
    case GET
    case HEAD
    case OPTIONS
    case PATCH
    case POST
    case PUT
    case TRACE
    
    var staticExeption: NKNStaticExecption? {
      switch self {
      case .HEAD, .PUT, .TRACE, .DELETE:
        return NKNStaticExecption.emptyResponseData
      default:
        return nil
      }
    }
  }
  
  func make(_ requestHTTPMethod: HTTPMethod, body: RequestT? = nil, handler: @escaping NKNRequestCompletion) {
    guard let connection = Reachability()?.connection, connection != Reachability.Connection.none else {
      handler(.failure(errorHandler?(nil, nil, NKNStaticError.noInternetConnection)
        ?? NKNStaticError.noInternetConnection))
      return
    }
    
    guard let url = endpoint.url(with: path, queryParameters: query) else {
      handler(.failure(NKNStaticError.invalidURL))
      return
    }
    
    let json: Data? = try? JSONEncoder().encode(body)
    
    let req: URLRequest? = {
      if body == nil {
        return self.request(requestHTTPMethod, with: url, header: header)
      } else {
        return self.request(requestHTTPMethod, with: url, header: header, body: json)
      }
    }()
      
  
    guard let request = req else {
      handler(.failure(NKNStaticError.invalidRequest))
      return
    }
    
    print(request)
    
    URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
      self?.print(data)
      
      if let exeptionHandler = self?.exceptionHandler, let apiExeption = exeptionHandler(data, response, error) {
        handler(.exception(apiExeption))
        return
      }
      
      if let errorHandler = self?.errorHandler, let apiError = errorHandler(data, response, error) {
        handler(.failure(apiError))
        return
      }
      
      if let error = error {
        handler(.failure(error))
        return
      }
      
      guard let data = data else {
        handler(requestHTTPMethod.staticExeption == .emptyResponseData ?
          .success(Data()) :
          .failure(self?.errorHandler?(nil, nil, NKNStaticError.emptyResponseData) ?? NKNStaticError.emptyResponseData))
        return
      }
      
      handler(.success(data))
      }.resume()
  }
}
//MARK: -

//MARK: - NKNRequestFetcher request creater
fileprivate extension NKNRequestFetcher {
  
  func request(_ type: HTTPMethod, with url: URL?, header: NKNHeaderParameters? = nil, body: Data? = nil) -> URLRequest? {
    guard let url = url else { return nil }
    var request = URLRequest(url: url)
    request.httpMethod = type.rawValue
    if let header = header {
      header.forEach {
        guard let key = $0.key, let value = $0.value else { return }
        request.addValue(value, forHTTPHeaderField: key)
      }
    }
    
    request.httpBody = body
    return request
  }
  
}
//MARK: -

//MARK: - NKNRequestFetcher log prints
fileprivate extension NKNRequestFetcher {
  
  func print(_ request: URLRequest) {
    guard printLogRequest else { return }
    
    let logText = "<" + String(describing: self) + " Header Fields: " + String(describing: request.allHTTPHeaderFields) + " >"
    debugPrint(logText)
  }
  
  func print(_ responseData: Data?) {
    guard let data = responseData, printLogResponse else { return }
    
    let logText = "<" + String(describing: self) + " Response Data: " + (String(data: data, encoding: logResponseEncodingFormat) ?? "") + " >"
    debugPrint(logText)
  }
}
//MARK: -
