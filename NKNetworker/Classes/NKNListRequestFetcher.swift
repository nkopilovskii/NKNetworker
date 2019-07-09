//
//  NKNListRequestFetcher.swift
//  NKNetworker
//
//  Created by Nick Kopilovskii on 7/9/19.
//

import Foundation


//MARK: - NKNListRequestFetcher
public class NKNListRequestFetcher<RequestT: Encodable, ResponseT: Decodable>: NKNEntityRequestFetcher<RequestT, [ResponseT]> {
  
  //MARK: Fetcher Completion Closure
  typealias ListRequestCompletion<ResponseT> = (NKNResponse<[ResponseT]>)-> ()
  
  override func validate(_ result: NKNResponse<Data>, then: @escaping ListRequestCompletion<ResponseT>) {
    switch result {
    case .success(let data):
      guard let decoded = try? JSONDecoder().decode([ResponseT].self, from: data) else {
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
