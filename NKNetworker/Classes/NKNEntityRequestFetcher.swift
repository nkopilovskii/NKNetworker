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
//  NKNEntityRequestFetcher.swift
//  NKNetworker
//
//  Created by Nick Kopilovskii on 7/9/19.
//

import Foundation

//MARK: - NKNEntityRequestFetcher
public class NKNEntityRequestFetcher<RequestT: Encodable, ResponseT: Decodable>: NKNRequestFetcher<RequestT> {
  
  //MARK: Fetcher Completion Closure
  public typealias EntityRequestCompletion<ResponseT> = (NKNResponse<ResponseT>)->()
  
  
  public func connect(_ then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.CONNECT) { response in
      self.validate(response, then: then)
    }
  }
  
  public func delete(_ body: RequestT? = nil, then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.DELETE, body: body) { response in
      self.validate(response, then: then)
    }
  }
  
  public func get(_ then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.GET) { response in
      self.validate(response, then: then)
    }
  }
  
  public func head(_ then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.HEAD) { response in
      self.validate(response, then: then)
    }
  }
  
  public func options(_ then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.OPTIONS) { response in
      self.validate(response, then: then)
    }
  }
  
  public func patch(_ body: RequestT? = nil, then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.PATCH, body: body) { response in
      self.validate(response, then: then)
    }
  }
  
  public func post(_ body: RequestT? = nil, then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.POST, body: body) {  response in
      self.validate(response, then: then)
    }
  }
  
  public func put(_ body: RequestT? = nil, then: @escaping EntityRequestCompletion<ResponseT>) {
    super.make(.PUT, body: body) { response in
      self.validate(response, then: then)
    }
  }
  
  public func trace(_ then: @escaping EntityRequestCompletion<ResponseT>) {
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
