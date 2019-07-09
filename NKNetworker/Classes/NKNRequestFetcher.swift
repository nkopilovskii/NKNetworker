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
public class NKNRequestFetcher<RequestT: Encodable> {
  
  //MARK: Base properties
  var endpoint: NKNEndpoint
  var header: NKNHeaderParameters?
  var path: NKNPathParameters?
  var query: NKNQueryParameters?
  
  var errorHandler: NKNResponseErrorHandler?
  var exceptionHandler: NKNResponseExeptionHandler?
  
  //MARK: Log properties
  var printLogRequest = false
  var logRequestEncodingFormat = String.Encoding.utf8
  
  var printLogResponse = false
  var logResponseEncodingFormat = String.Encoding.utf8
  
  required init(_ endpoint: NKNEndpoint, header: NKNHeaderParameters? = nil, path: NKNPathParameters? = nil, query: NKNQueryParameters? = nil, errorHandler: NKNResponseErrorHandler? = nil, exeptionHandler: NKNResponseExeptionHandler? = nil) {
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
      handler(.failure(NKNStaticError.noInternetConnection))
      return
    }
    
    guard let url = endpoint.url(with: path, queryParameters: query) else {
      handler(.failure(NKNStaticError.invalidURL))
      return
    }
    
    let json = try? JSONEncoder().encode(body)
    guard let request = NKNRequestFetcher.request(requestHTTPMethod, with: url, header: header, body: json) else {
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
        handler(requestHTTPMethod.staticExeption == .emptyResponseData ? .success(Data()) : .failure(NKNStaticError.emptyResponseData))
        return
      }
      
      
      handler(.success(data))
      }.resume()
  }
  
  
  
}
//MARK: -

//MARK: - NKNRequestFetcher request creater
fileprivate extension NKNRequestFetcher {
  
  static func request(_ type: HTTPMethod, with url: URL?, header: NKNHeaderParameters? = nil, body: Data? = nil) -> URLRequest? {
    guard let url = url else { return nil }
    var request = URLRequest(url: url)
    request.httpMethod = type.rawValue
    request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
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
    
    let logText = "<\(String(describing: self)) >"
    debugPrint(logText)
  }
  
  func print(_ responseData: Data?) {
    guard printLogResponse else { return }
    
    let logText = "<\(String(describing: self)) >"
    debugPrint(logText)
  }
}
//MARK: -
