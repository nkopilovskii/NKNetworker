//
//  NKNEntityRequestFetcher.swift
//  NKNetworker
//
//  Created by Nick Kopilovskii on 7/9/19.
//

import Foundation

//MARK: - NKNEntityRequestFetcher
public class NKNEntityRequestFetcher<RequestT: Encodable, ResponseT: Decodable>: NKNRequestFetcher<RequestT> {
  
  //MARK: Fetcher Completion Closure
  typealias EntityRequestCompletion<ResponseT> = (NKNResponse<ResponseT>)->()
  
  
  func connect(_ then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.CONNECT) { response in
      self.validate(response, then: then)
    }
  }
  
  func delete(_ body: RequestT? = nil, then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.DELETE, body: body) { response in
      self.validate(response, then: then)
    }
  }
  
  func get(_ then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.GET) { response in
      self.validate(response, then: then)
    }
  }
  
  func head(_ then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.HEAD) { response in
      self.validate(response, then: then)
    }
  }
  
  func options(_ then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.OPTIONS) { response in
      self.validate(response, then: then)
    }
  }
  
  func patch(_ body: RequestT? = nil, then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.PATCH, body: body) { response in
      self.validate(response, then: then)
    }
  }
  
  func post(_ body: RequestT? = nil, then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.POST, body: body) {  response in
      self.validate(response, then: then)
    }
  }
  
  func put(_ body: RequestT? = nil, then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.PUT, body: body) { response in
      self.validate(response, then: then)
    }
  }
  
  func trace(_ then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.TRACE) { response in
      self.validate(response, then: then)
    }
  }
  
  func validate(_ result: NKNResponse<Data>, then: @escaping EntityRequestCompletion<ResponseT>) {
    switch result {
    case .success(let data):
      guard let decoded = try? JSONDecoder().decode(ResponseT.self, from: data) else {
        then(.failure(NKNStaticError.undecoded))
        return
      }
      then(.success(decoded))
    case .exception(let exeption): then(.exception(exeption))
    case .failure(let error): then(.failure(error))
    }
  }
}
//MARK: -
